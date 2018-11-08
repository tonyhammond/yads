# 
# 
#   Description of Echo example using YADS.
# 
# 
(
  #  feed 
  type => "feed"
  property => (
    literal => "My First Weblog"
    type => "title"
  )
  property => (
    literal => "Ain't the Interweb great?"
    type => "subtitle"
  )
  property => (
    literal => "http://bob.blog/"
    type => "link"
  )
  property => (
    literal => "2003-02-05T12:29:29Z"
    type => "created"
  )
  property => (
    literal => "2003-02-05T12:29:29Z"
    type => "issued"
  )
  property => (
    literal => "2003-02-05T12:29:29Z"
    type => "modified"
  )
  [
    (
      #  entry 
      type => "entry"
      property => (
        literal => "My First Entry"
        type => "title"
      )
      property => (
        literal => "In which a newbie learns to blog..."
        type => "subtitle"
      )
      property => (
        literal => "A very boring entry; just learning how to blog here..."
        type => "summary"
      )
      property => (
        literal => "http://bob.blog/28"
        type => "link"
      )
      property => (
        literal => "http://bob.blog/28"
        type => "id"
      )
      property => (
        literal => "2003-02-05T12:29:29Z"
        type => "created"
      )
      property => (
        literal => "2003-02-05T12:29:29Z"
        type => "issued"
      )
      property => (
        literal => "2003-02-05T12:29:29Z"
        type => "modified"
      )
      [
        (
          #  author 
          type => "author"
          property => (
            literal => "Bob B. Bobbington"
            type => "name"
          )
          property => (
            literal => "http://bob.name/"
            type => "homepage"
          )
          property => (
            literal => "http://bob.name/"
            type => "weblog"
          )
        )
        (
          #  contributor 
          type => "contributor"
          property => (
            literal => "Yo-Yo Dyne"
            type => "name"
          )
          property => (
            literal => "http://yoyo.dyne.name/"
            type => "homepage"
          )
          property => (
            literal => "http://yoyo.dyne.name/"
            type => "weblog"
          )
        )
        (
          #  content 
          type => "content"
          property => (
            literal => "application/xhtml+xml"
            type => "type"
          )
          property => (
            literal => "en-us"
            type => "lang"
          )
          property => (
            literal => "<p xmlns=\"...\">Hello, <em>weblog</em> world! 2 < 4!</p>"
            type => "content"
          )
        )
      ]
    )
  ]
)
