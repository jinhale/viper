# commands.rb - sets up commands defined here

Viper::Commands::CMD_PATH.unshift({ 
ls: ->(*args, env:{}){ ls(*args, out:env[:out]) }
})

