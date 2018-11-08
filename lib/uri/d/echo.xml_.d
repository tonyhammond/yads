# 
# 
#   Description of URI syntax (from RFC 2396) modelled using YADS.
# 
# 
(*
  #  channel 
  resource => <http://bob.blog/>
  [
    (
      resource => <http://...2>
      property => (
            resource => <data:,ScienceDirect>
        type => "label"
      )
      property => (
            resource => <data:,image>
        type => "type"
      )
    )
    (
      resource => <http://...3>
      property => (
            resource => <data:,Graphical%20Abstracts>
        type => "ex-label"
      )
      property => (
            resource => <data:,Graphical%20Abstracts%20jg%20%20uiugyt%20%20%20%20yuy%20%20y%20yy%20%20%20j%20
%20yiuouioi%20i%20i%20oi%20%20oi%20oi%20oi%20i%20o%20ii

%20iuiuu%20u%20>
        type => "detail"
      )
      property => (
            resource => <data:,item>
        type => "type"
      )
    )
    (
      resource => <http://...4>
      property => (
            resource => <data:,Solid-supported%20...>
        type => "label"
      )
      property => (
            resource => <data:,item>
        type => "type"
      )
    )
  ]
  property => (
    resource => <data:,feed>
    type => "type"
  )
  (
    resource => <data:,My%20First%20Weblog>
    property => (
        resource => <data:,title>
      type => "type"
    )
  )
  (
    resource => <data:,Ain't%20the%20Interweb%20great?>
    property => (
        resource => <data:,subtitle>
      type => "type"
    )
  )
*)
