
require_relative '../lib/termline'

Termline.br
Termline.br

Termline.m("Simple message")

Termline.br

Termline.msg("Simple message")
Termline.msg("Message with data:", data:{ name: "Luis", last_name: "Donis", title: "Software developer"})

Termline.br

Termline.info("Simple message")
Termline.info("Message with data:", data:{ name: "Luis", last_name: "Donis", title: "Software developer"})

Termline.br

Termline.success("Simple message")
Termline.success("Message with data:", data:{ name: "Luis", last_name: "Donis", title: "Software developer"})

Termline.br

Termline.warning("Simple message")
Termline.warning("Message with data:", data:{ name: "Luis", last_name: "Donis", title: "Software developer"})

Termline.br

Termline.danger("Simple message")
Termline.danger("Message with data:", data:{ name: "Luis", last_name: "Donis", title: "Software developer"})


Termline.br
Termline.list("one", "two", "three")

Termline.br
Termline.list("four", "five", "six", color: :yellow)

Termline.br
Termline.list("four", "five", "six", color: :green, icon: :star)

Termline.br

Termline.table(
    [
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
    ]
)

# # Termline.br 
# # Termline.br 
