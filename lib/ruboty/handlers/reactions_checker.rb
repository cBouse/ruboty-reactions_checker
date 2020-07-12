require 'slack'

module Ruboty
  module Handlers
    class Reactions < Base
      env :SLACK_TOKEN, 'Slack API Token', optional: false

      on(
        /check reactions\s?(?<option>(-c|-m)?)((?<message>\s+.*)?)\z/m,
        name: 'reactions',
        description: 'Mention members who is not reacting'
      )

      def reactions(message)
        token = ENV['SLACK_TOKEN']
        client = Slack::Client.new token: token

        return unless message.original[:thread_ts]

        reactions = client.reactions_get(
          channel: message.original[:channel]['id'],
          timestamp: message.original[:thread_ts]
        )

        reaction_members = []
        target_members = []
        is_break = false
        reply = ''
        reactions['message']['blocks'][0]['elements'].each do |element|
          element['elements'].each do |inner_element|
            if inner_element['type'] == 'broadcast' || message[:option] == '-c'
              unless message[:option] == '-m'
                members = client.conversations_members(channel: message.original[:channel]['id'])['members']
                members.each { |member| target_members << member }
                is_break = true
                break
              end
            elsif inner_element['type'] == 'user'
              target_members << inner_element['user_id']
            end
          end
          break if is_break
        end
        target_members = target_members.uniq

        if reactions['message'].has_key?('reactions')
          reactions['message']['reactions'].each do |reaction|
            reaction['users'].each do |user|
              reaction_members << user
            end
          end
        end
        target_members -= reaction_members

        target_members.each do |member|
          next if client.users_info(user: member)['user']['is_bot']
          reply << '<@' << member << '> '
        end

        if message[:message]
          if message[:message].start_with?('-')
            reply = 'makes no sense'
          else
            reply << message[:message]
          end
        end

        message.reply(reply)
      end
    end
  end
end
