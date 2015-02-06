xquery version "3.0";

let $base-uri := 'http://www.ipe.fzk.de/~mn5384/T_Hs_152_1230_4_/'
let $links := httpclient:get(xs:anyURI($base-uri), false(), ())//a[ends-with(@href, '.xml')]
return
<SwatiXml>
    {
    for $url in $links/@href/string()
    let $swati-xml := httpclient:get(xs:anyURI($base-uri || $url), false(), ())
    return
    <Page_Measure>
        { ($swati-xml//ImageID)[1] }
        {
        for $zone in $swati-xml//zone
        return
            <zone>
                {
                $zone/(zoneID|RelativeWidth_Percentage|RelativeHeight_Percentage|BX_Percentage|BY_Percentage)
                }
            </zone>
        }
    </Page_Measure>
    }
</SwatiXml>
