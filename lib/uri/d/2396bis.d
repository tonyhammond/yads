# 
# 
#   Description of URI syntax from RFC 2396bis(#3) modelled using YADS.
# 
#   Productions marked with an asterisk have not been modelled,
#   This is purely to keep the visualization simpler.
# 
#   ==
# 
#   URI-reference = URI / relative-URI
#   URI           = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
#   relative-URI  = hier-part [ "?" query ] [ "#" fragment ]
# * absolute-URI  = scheme ":" hier-part [ "?" query ]
#  
#   scheme        = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )
#   hier-part     = net-path / abs-path / rel-path
#   query         = *( pchar / "/" / "?" )
#   fragment      = *( pchar / "/" / "?" )
#  
#  
#   net-path      = "//" authority [ abs-path ]
#   abs-path      = "/" path-segments
#   rel-path      = path-segments
#  
#   authority     = [ userinfo "@" ] host [ ":" port ]
#   userinfo      = *( unreserved / escaped / ";" /
#                      ":" / "&" / "=" / "+" / "$" / "," )
#   host          = [ IPv6reference / IPv4address / hostname ]
#   IPv6reference = "[" IPv6address "]"
# * IPv6address   =                          6( h4 ":" ) ls32
#                 /                     "::" 5( h4 ":" ) ls32
#                 / [              h4 ] "::" 4( h4 ":" ) ls32
#                 / [ *1( h4 ":" ) h4 ] "::" 3( h4 ":" ) ls32
#                 / [ *2( h4 ":" ) h4 ] "::" 2( h4 ":" ) ls32
#                 / [ *3( h4 ":" ) h4 ] "::"    h4 ":"   ls32
#                 / [ *4( h4 ":" ) h4 ] "::"             ls32
#                 / [ *5( h4 ":" ) h4 ] "::"             h4
#                 / [ *6( h4 ":" ) h4 ] "::"
#   IPv4address   = dec-octet "." dec-octet "." dec-octet "." dec-octet
#   hostname      = domainlabel qualified
#   port          = *DIGIT
#  
# * h4            = 1*4HEXDIG
# * ls32          = ( h4 ":" h4 ) / IPv4address
# * dec-octet     = DIGIT                 ; 0-9
#                 / %x31-39 DIGIT         ; 10-99
#                 / "1" 2DIGIT            ; 100-199
#                 / "2" %x30-34 DIGIT     ; 200-249
# 
#   domainlabel   = alphanum [ 0*61( alphanum / "-" ) alphanum ]
#                 / "25" %x30-35          ; 250-255
#   qualified     = *( "." domainlabel ) [ "." ]
#   alphanum      = ALPHA / DIGIT
#  
#   path-segments = segment *( "/" segment )
#   segment       = *pchar
#   pchar         = unreserved / escaped / ";" /
#                   ":" / "@" / "&" / "=" / "+" / "$" / ","
#  
#   unreserved    = ALPHA / DIGIT / mark
#   escaped       = "%" HEXDIG HEXDIG
#   mark          = "-" / "_" / "." / "!" / "~" / "*" / "'" / "(" / ")"
#  
# 
(*
  #   2396bis(#3) 
  resource => <data:,>
  <
    (*
      #  \#1: URI-reference 
      resource => <data:,URI-reference>
      <
        (*
          #  \#2: URI 
          resource => <data:,URI>
          [
            (*
              #  \#5: scheme 
              resource => <data:,scheme>
              [
                (
                  resource => <data:,ALPHA>
                )
                (
                  <
                    (
                      resource => <data:,ALPHA>
                    )
                    (
                      resource => <data:,DIGIT>
                    )
                    (
                      resource => <data:,%2B>
                    )
                    (
                      resource => <data:,->
                    )
                    (
                      resource => <data:,.>
                    )
                  >
                )
              ]
              type => "bnf:Rule"
            *)
            (
              resource => <data:,%3A>
            )
            (*
              #  \#6: hier-part 
              resource => <data:,hier-part>
              <
                (*
                  #  \#9: net-path 
                  resource => <data:,net-path>
                  [
                    (
                      resource => <data:,%2F%2F>
                    )
                    (*
                      #  \#12: authority 
                      resource => <data:,authority>
                      [
                        (*
                          #  \#13: userinfo 
                          resource => <data:,userinfo>
                          <
                            (*
                              #  \#29: unreserved 
                              resource => <data:,unreserved>
                              <
                                (
                                  resource => <data:,ALPHA>
                                )
                                (
                                  resource => <data:,DIGIT>
                                )
                                (*
                                  #  \#31: mark 
                                  resource => <data:,mark>
                                  <
                                    (
                                      resource => <data:,->
                                    )
                                    (
                                      resource => <data:,_>
                                    )
                                    (
                                      resource => <data:,.>
                                    )
                                    (
                                      resource => <data:,%21>
                                    )
                                    (
                                      resource => <data:,%7E>
                                    )
                                    (
                                      resource => <data:,%2A>
                                    )
                                    (
                                      resource => <data:,%27>
                                    )
                                    (
                                      resource => <data:,%28>
                                    )
                                    (
                                      resource => <data:,%29>
                                    )
                                  >
                                  type => "bnf:Rule"
                                *)
                              >
                              type => "bnf:Rule"
                            *)
                            (*
                              #  \#30: escaped 
                              resource => <data:,escaped>
                              [
                                (
                                  resource => <data:,%25>
                                )
                                (
                                  resource => <data:,HEXDIG>
                                )
                                (
                                  resource => <data:,HEXDIG>
                                )
                              ]
                              type => "bnf:Rule"
                            *)
                            (
                              resource => <data:,%3B>
                            )
                            (
                              resource => <data:,%3A>
                            )
                            (
                              resource => <data:,%26>
                            )
                            (
                              resource => <data:,%3D>
                            )
                            (
                              resource => <data:,%2B>
                            )
                            (
                              resource => <data:,%24>
                            )
                            (
                              resource => <data:,%2C>
                            )
                          >
                          type => "bnf:Rule"
                        *)
                        (
                          resource => <data:,%40>
                        )
                        (*
                          #  \#14: host 
                          resource => <data:,host>
                          <
                            (*
                              #  \#15: IPv6reference 
                              resource => <data:,IPv6reference>
                              [
                                (
                                  resource => <data:,%5A>
                                )
                                (*
                                  #  \#16: IPv6address (not expanded) 
                                  resource => <data:,IPv6address>
                                  <
                                  >
                                  type => "bnf:Rule"
                                *)
                                (
                                  resource => <data:,%5D>
                                )
                              ]
                              type => "bnf:Rule"
                            *)
                            (*
                              #  \#17: IPv4address 
                              resource => <data:,IPv4address>
                              <
                                (*
                                  #  \#22: dec-octet (not expanded) 
                                  resource => <data:,dec-octet>
                                  <
                                  >
                                  type => "bnf:Rule"
                                *)
                                (
                                  resource => <data:,.>
                                )
                                (
                                  resource => <data:,dec-octet>
                                )
                                (
                                  resource => <data:,.>
                                )
                                (
                                  resource => <data:,dec-octet>
                                )
                                (
                                  resource => <data:,.>
                                )
                                (
                                  resource => <data:,dec-octet>
                                )
                              >
                              type => "bnf:Rule"
                            *)
                            (*
                              #  \#18: hostname 
                              resource => <data:,hostname>
                              [
                                (*
                                  #  \#23: domainlabel 
                                  resource => <data:,domainlabel>
                                  <
                                    (
                                      [
                                        (*
                                          #  \#25: alphanum 
                                          resource => <data:,alphanum>
                                          <
                                            (
                                              resource => <data:,ALPHA>
                                            )
                                            (
                                              resource => <data:,DIGIT>
                                            )
                                          >
                                          type => "bnf:Rule"
                                        *)
                                        (
                                          [
                                            (
                                              <
                                                (
                                                  resource => <data:,alphanum>
                                                )
                                                (
                                                  resource => <data:,->
                                                )
                                              >
                                            )
                                            (
                                              resource => <data:,alphanum>
                                            )
                                          ]
                                        )
                                      ]
                                    )
                                    (
                                      [
                                        (
                                          resource => <data:,25>
                                        )
                                        (
                                          resource => <data:,%25x30-35>
                                        )
                                      ]
                                    )
                                  >
                                  type => "bnf:Rule"
                                *)
                                (*
                                  #  \#24: qualified 
                                  resource => <data:,qualified>
                                  [
                                    (
                                      [
                                        (
                                          resource => <data:,.>
                                        )
                                        (
                                          resource => <data:,domainlabel>
                                        )
                                      ]
                                    )
                                    (
                                      resource => <data:,.>
                                    )
                                  ]
                                  type => "bnf:Rule"
                                *)
                              ]
                              type => "bnf:Rule"
                            *)
                          >
                          type => "bnf:Rule"
                        *)
                        (
                          resource => <data:,%3A>
                        )
                        (*
                          #  \#19: port 
                          resource => <data:,port>
                          <
                            (
                              resource => <data:,DIGIT>
                            )
                          >
                          type => "bnf:Rule"
                        *)
                      ]
                      type => "bnf:Rule"
                    *)
                    (
                      resource => <data:,abs-path>
                    )
                  ]
                  type => "bnf:Rule"
                *)
                (*
                  #  \#10: abs-path 
                  resource => <data:,abs-path>
                  [
                    (
                      resource => <data:,%2F>
                    )
                    (*
                      #  \#26: path-segments 
                      resource => <data:,path-segments>
                      [
                        (*
                          #  \#27: segment 
                          resource => <data:,segment>
                          <
                            (*
                              #  \#28: pchar 
                              resource => <data:,pchar>
                              <
                                (
                                  resource => <data:,unreserved>
                                )
                                (
                                  resource => <data:,escaped>
                                )
                                (
                                  resource => <data:,%3B>
                                )
                                (
                                  resource => <data:,%3A>
                                )
                                (
                                  resource => <data:,%40>
                                )
                                (
                                  resource => <data:,%26>
                                )
                                (
                                  resource => <data:,%3D>
                                )
                                (
                                  resource => <data:,%2B>
                                )
                                (
                                  resource => <data:,%24>
                                )
                                (
                                  resource => <data:,%2C>
                                )
                              >
                              type => "bnf:Rule"
                            *)
                          >
                          type => "bnf:Rule"
                        *)
                        (
                          [
                            (
                              resource => <data:,%2F>
                            )
                            (
                              resource => <data:,segment>
                            )
                          ]
                        )
                      ]
                      type => "bnf:Rule"
                    *)
                  ]
                  type => "bnf:Rule"
                *)
                (*
                  #  \#11: rel-path 
                  resource => <data:,rel-path>
                  [
                    (
                      resource => <data:,path-segments>
                    )
                  ]
                  type => "bnf:Rule"
                *)
              >
              type => "bnf:Rule"
            *)
            (
              [
                (
                  resource => <data:,%3F>
                )
                (*
                  #  \#7: query 
                  resource => <data:,query>
                  [
                    (
                      resource => <data:,pchar>
                    )
                    (
                      resource => <data:,%2F>
                    )
                    (
                      resource => <data:,%3F>
                    )
                  ]
                  type => "bnf:Rule"
                *)
              ]
            )
            (
              [
                (
                  resource => <data:,%23>
                )
                (*
                  #  \#8: fragment 
                  resource => <data:,fragment>
                  [
                    (
                      resource => <data:,pchar>
                    )
                    (
                      resource => <data:,%2F>
                    )
                    (
                      resource => <data:,%3F>
                    )
                  ]
                  type => "bnf:Rule"
                *)
              ]
            )
          ]
          type => "bnf:Rule"
        *)
        (*
          #  \#3: relative-URI 
          resource => <data:,relative-URI>
          [
            (
              resource => <data:,hier-part>
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
            (
              [
                (
                  resource => <data:,%23>
                )
                (
                  resource => <data:,fragment>
                )
              ]
            )
          ]
          type => "bnf:Rule"
        *)
      >
      type => "bnf:Rule"
    *)
    (*
      #  \#4: absolute-URI (not expanded) 
      resource => <data:,absolute-URI>
      [
      ]
      type => "bnf:Rule"
    *)
  >
*)
