<button 
<#if btntype??>
type=${btntype}
</#if>
<#if btnautofocus??>
autofocus=${btnautofocus}
</#if>
<#if btndisabled??>
disabled=${btndisabled}
</#if>
<#if btnname??>
name=${btnname}
</#if>
<#if btnform??>
form=${btnform}
</#if>
<#if btnvalue??>
value=${btnvalue}
</#if>
<#if btnclass??>
class=${btnclass}
</#if>
<#if btnevent??>
onclick=${btnevent}
</#if> >
<#if btntext??>
${btntext}
</#if>

</button>