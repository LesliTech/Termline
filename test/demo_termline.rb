
require_relative '../lib/termline'

Termline.br
Termline.br

Termline.m("Simple message")

Termline.br

Termline.msg("Simple message")
Termline.msg("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br

Termline.info("Simple message")
Termline.info("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br

Termline.success("Simple message")
Termline.success("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")
Termline.success("Connected", tag: "DB", adapter: "postgres", time: "12ms")
Termline.br

Termline.warning("Simple message")
Termline.warning("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br

Termline.danger("Simple message")
Termline.danger("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br
Termline.br
Termline.list("one", "two", "three")

Termline.br
Termline.list("four", "five", "six", color: :yellow)

Termline.br
Termline.list("four", "five", "six", color: :green, icon: :star)

Termline.br
Termline.br

Termline.table(
    [
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
    ]
)

Termline.br
Termline.br

Termline.table(
  [
    { endpoint: "/users", method: "GET", status: 200, time: "45ms" },
    { endpoint: "/users", method: "POST", status: 201, time: "82ms" },
    { endpoint: "/login", method: "POST", status: 401, time: "17ms" }
  ]
)


Termline.br
Termline.br

Termline.table(
    [
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
    ], header: false
)

Termline.br
Termline.br

Termline.table([
    ["Luis", "Admin", "Active"],
    ["Ana", "Developer", "Pending"],
    ["Marco", "Support", "Disabled"]
])
