# 
# 
#   Description of URI syntax for a 'doi' URI modelled using YADS.
# 
#   ==
# 
#   doi-uri        = scheme ":" encoded-doi [ "?" query ] 
#                                           [ "#" fragment ]
# 
#   scheme         = "doi" 
# 
#   encoded-doi    = prefix "/" suffix 
#   prefix         = segment
#   suffix         = segment *( "/" segment )
# 
#   segment        = *pchar
# 
#   query          = *( pchar / "/" / "?" )
#   fragment       = *( pchar / "/" / "?" )
# 
#   pchar          = unreserved / escaped / ";" /
#                    ":" / "@" / "&" / "=" / "+" / "$" / ","
# 
#   unreserved     = ALPHA / DIGIT / mark
#   escaped        = "%" HEXDIG HEXDIG
#   mark           = "-" / "_" / "." / "!" / "~" / "*" / "'" /
#                    "(" / ")"
# 
# 
(*
  #  \#1: doi-uri 
  resource => <data:,doi-uri>
  [
    (*
      #  \#2: scheme 
      resource => <data:,scheme>
      {
        (
          resource => <data:,doi>
        )
      }
      type => "bnf:Rule"
    *)
    (
      resource => <data:,%3A>
    )
    (*
      #  \#3: encoded-doi 
      resource => <data:,encoded-doi>
      {
        (*
          #  \#4: prefix 
          resource => <data:,prefix>
          {
            (*
              #  \#6: segment 
              resource => <data:,segment>
              <
                (*
                  #  \#28: pchar 
                  resource => <data:,pchar>
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
                *)
              >
              type => "bnf:Rule"
            *)
          }
          type => "bnf:Rule"
        *)
        (*
          #  \#5: suffix 
          resource => <data:,suffix>
          {
            (
              resource => <data:,%2F>
            )
            (
              resource => <data:,segment>
            )
          }
          type => "bnf:Rule"
        *)
      }
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
