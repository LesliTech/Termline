
require_relative '../lib/termline'

Termline.br
Termline.br

Termline.title("Messages")
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
Termline.success("Connected", tag: "DB", adapter: "postgres", duration: "12ms")
Termline.br

Termline.warning("Simple message")
Termline.warning("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br

Termline.danger("Simple message")
Termline.danger("Message with data:", name: "Luis", last_name: "Donis", title: "Software developer")

Termline.br
Termline.br
Termline.title("Lists")
Termline.list("one", "two", "three")

Termline.br
Termline.list("four", "five", "six", color: :yellow)

Termline.br
Termline.list("four", "five", "six", color: :green, icon: :star)

Termline.br 2
Termline.ordered_list("Install", "Configure", "Run", color: :blue)

Termline.br 2
Termline.title("Environment")
Termline.key_value(environment: "development", ruby: RUBY_VERSION, workers: 4)

Termline.br 2
Termline.title("Tables")

Termline.table(
    [
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
        { first_name: "Luis", last_name: "Donis", title: "software developer" },
    ],
    align: { first_name: :left, last_name: :left, title: :center }
)

Termline.br 2

Termline.table(
  [
    { endpoint: "/users", method: "GET", status: 200, time: "45ms" },
    { endpoint: "/users", method: "POST", status: 201, time: "82ms" },
    { endpoint: "/login", method: "POST", status: 401, time: "17ms" }
  ], header: false
)

Termline.br 2

Termline.table([
    ["Luis", "Admin", "Active"],
    ["Ana", "Developer", "Pending"],
    ["Marco", "Support", "Disabled"]
])

Termline.br 2
Termline.line
