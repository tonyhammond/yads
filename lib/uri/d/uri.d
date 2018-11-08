# 
# 
#   Description of URI syntax (from RFC 2396) modelled using YADS.
# 
#   Only those productions marked with an asterisk are modelled,
#   ie those with non-terminal elements. This is purely to keep
#   the visualization simpler.
# 
#   ==
# 
# * URI-reference = [ absoluteURI | relativeURI ] [ "#" fragment ]
# * absoluteURI   = scheme ":" ( hier_part | opaque_part )
# * relativeURI   = ( net_path | abs_path | rel_path ) [ "?" query ]
# 
# * hier_part     = ( net_path | abs_path ) [ "?" query ]
# * opaque_part   = uric_no_slash *uric
# 
#   uric_no_slash = unreserved | escaped | ";" | "?" | ":" | "@" |
#                   "&" | "=" | "+" | "$" | ","
# 
# * net_path      = "//" authority [ abs_path ]
# * abs_path      = "/"  path_segments
# * rel_path      = rel_segment [ abs_path ]
# 
#   rel_segment   = 1*( unreserved | escaped |
#                       ";" | "@" | "&" | "=" | "+" | "$" | "," )
# 
#   scheme        = alpha *( alpha | digit | "+" | "-" | "." )
# 
# * authority     = server | reg_name
# 
#   reg_name      = 1*( unreserved | escaped | "$" | "," |
#                       ";" | ":" | "@" | "&" | "=" | "+" )
# 
# * server        = [ [ userinfo "@" ] hostport ]
#   userinfo      = *( unreserved | escaped |
#                      ";" | ":" | "&" | "=" | "+" | "$" | "," )
# 
# * hostport      = host [ ":" port ]
# * host          = hostname | IPv4address
# * hostname      = *( domainlabel "." ) toplabel [ "." ]
#   domainlabel   = alphanum | alphanum *( alphanum | "-" ) alphanum
#   toplabel      = alpha | alpha *( alphanum | "-" ) alphanum
#   IPv4address   = 1*digit "." 1*digit "." 1*digit "." 1*digit
#   port          = *digit
# 
# * path          = [ abs_path | opaque_part ]
# * path_segments = segment *( "/" segment )
# * segment       = *pchar *( ";" param )
# * param         = *pchar
#   pchar         = unreserved | escaped |
#                   ":" | "@" | "&" | "=" | "+" | "$" | ","
# 
# * query         = *uric
# 
# * fragment      = *uric
# 
#   uric          = reserved | unreserved | escaped
#   reserved      = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
#                   "$" | ","
#   unreserved    = alphanum | mark
#   mark          = "-" | "_" | "." | "!" | "~" | "*" | "'" |
#                   "(" | ")"
# 
#   escaped       = "%" hex hex
#   hex           = digit | "A" | "B" | "C" | "D" | "E" | "F" |
#                           "a" | "b" | "c" | "d" | "e" | "f"
# 
#   alphanum      = alpha | digit
#   alpha         = lowalpha | upalpha
# 
#   lowalpha = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" |
#              "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" |
#              "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"
#   upalpha  = "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" |
#              "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" |
#              "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z"
#   digit    = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" |
#              "8" | "9"
# 
# 
(*
  #  \#1: URI-reference 
  resource => <data:,URI-reference>
  [
    (
      <
        (*
          #  \#2: absoluteURI 
          resource => <data:,absoluteURI>
          [
            (
              resource => <data:,scheme>
            )
            (
              resource => <data:,%3A>
            )
            (
              <
                (*
                  #  \#4: hier_part 
                  resource => <data:,hier_part>
                  {
                    (
                      <
                        (*
                          #  \#7: net_path 
                          resource => <data:,net_path>
                          [
                            (
                              resource => <data:,%2F%2F>
                            )
                            (*
                              resource => <data:,authority>
                              #  \#12: authority 
                              {
                                (*
                                  #  \#14: server 
                                  resource => <data:,server>
                                  [
                                    (
                                      resource => <data:,userinfo>
                                    )
                                    (
                                      resource => <data:,%40>
                                    )
                                    (*
                                      #  \#16: hostport 
                                      resource => <data:,hostport>
                                      [
                                        (*
                                          #  \#17: host 
                                          resource => <data:,host>
                                          <
                                            (*
                                              #  \#18: hostname 
                                              resource => <data:,hostname>
                                              [
                                                (
                                                  resource => <data:,domainlabel>
                                                )
                                                (
                                                  resource => <data:,.>
                                                )
                                                (
                                                  resource => <data:,toplabel>
                                                )
                                                (
                                                  resource => <data:,.>
                                                )
                                              ]
                                              type => "bnf:Rule"
                                            *)
                                            (*
                                              resource => <data:,IPv4address>
                                              type => "bnf:Rule"
                                            *)
                                          >
                                          type => "bnf:Rule"
                                        *)
                                        (
                                          resource => <data:,%3A>
                                        )
                                        (*
                                          resource => <data:,port>
                                          type => "bnf:Rule"
                                        *)
                                      ]
                                      type => "bnf:Rule"
                                    *)
                                  ]
                                  type => "bnf:Rule"
                                *)
                                (*
                                  resource => <data:,reg_name>
                                  type => "bnf:Rule"
                                *)
                              }
                              type => "bnf:Rule"
                            *)
                            (*
                              #  \#8: abs_path 
                              resource => <data:,abs_path>
                              [
                                (
                                  resource => <data:,%2F>
                                )
                                (*
                                  #  \#24: path_segments 
                                  resource => <data:,path_segments>
                                  [
                                    (*
                                      #  \#25: segment 
                                      resource => <data:,segment>
                                      [
                                        (
                                          resource => <data:,pchar>
                                        )
                                        (
                                          resource => <data:,%3B>
                                        )
                                        (*
                                          #  \#26: param 
                                          resource => <data:,param>
                                          {
                                            (
                                              resource => <data:,pchar>
                                            )
                                          }
                                          type => "bnf:Rule"
                                        *)
                                      ]
                                      type => "bnf:Rule"
                                    *)
                                    (
                                      resource => <data:,%2F>
                                    )
                                  ]
                                  type => "bnf:Rule"
                                *)
                              ]
                              type => "bnf:Rule"
                            *)
                          ]
                          type => "bnf:Rule"
                        *)
                      >
                    )
                    (
                      [
                        (
                          resource => <data:,%3F>
                        )
                        (*
                          resource => <data:,query>
                          {
                            (
                              resource => <data:,uric>
                            )
                          }
                        *)
                      ]
                    )
                  }
                  type => "bnf:Rule"
                *)
                (*
                  #  \#5: opaque_part 
                  resource => <data:,opaque_part>
                  [
                    (
                      resource => <data:,uric_no_slash>
                    )
                    (
                      resource => <data:,uric>
                    )
                  ]
                  type => "bnf:Rule"
                *)
              >
            )
          ]
          type => "bnf:Rule"
        *)
        (*
          #  \#3: relativeURI 
          resource => <data:,relativeURI>
          [
            (
              <
                (
                  resource => <data:,net_path>
                )
                (
                  resource => <data:,abs_path>
                )
                #  \#9: rel_path
# <nest>
# <data>rel_path</data>
# <collection order="sequenced">
# <item>
# <data>rel_segment</data>
# </item>
# </collection>
# <property type="type">bnf:Rule</property>
# </nest>
# 
              >
            )
            (
              [
                (
                  resource => <data:,%3F>
                )
                (
                  resource => <data:,query>
                )
              ]
            )
          ]
          type => "bnf:Rule"
        *)
      >
    )
    (
      [
        (
          resource => <data:,%23>
        )
        (*
          resource => <data:,fragment>
          {
            (
              resource => <data:,uric>
            )
          }
        *)
      ]
    )
  ]
  type => "bnf:Rule"
*)
