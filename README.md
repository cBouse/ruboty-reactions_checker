# Ruboty::Reactions_checker

Ruboty handler to mention members who is not reacting.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-reactions_checker', '=<version>', github: "cBouse/Reactions_checker.git"
```

## Env

```
SALCK_TOKEN - Slack API Token
```

## Usage

```
@ruboty check reactions <option(optional)> <message(optional)>
```

This checker checks all mention includes broadcast.  
Also, you can set these options.
```
-c -> check reactions from channel members
-m -> check reactions from mentions
```

## Example
channel members : \@cBouse \@moomin
```
> @here Test announce(nobody react)
    > @ruboty check reactions
bot > @cBouse @moomin

> @here Test announce(cBouse react)
    > @ruboty check reactions
bot > @moomin

> @moomin Test announce(nobody react)
    > @ruboty check reactions Plz react
bot > @moomin Plz react

> @cBouse Test announce(cBouse react)
    > @ruboty check reactions -c Plz react
bot > @moomin Plz react
```
