<select 
<#if _class??>
class="${_class}"
</#if>
<#if id??>
id="${id}" 
</#if>
<#if style??>
style="${style}" 
</#if>
<#if dataBind??>
data-bind="${dataBind}" 
</#if>
<#if disabled??>
disabled="${disabled}" 
</#if>
<#if name??>
name="${name}" 
</#if>
<#if onchange??>
onchange="${onchange}" 
</#if>
>
<#if optionsCaption??>
<option value="">${optionsCaption}</option> 
</#if>

<#if codeTableOptions??>
<#list codeTableOptions as codeTableOption>
<#if codeTableOption.isselected??&&codeTableOption.isselected=="true">
<option value="${codeTableOption.itemCode}" title="${codeTableOption.desc}" selected="selected">${codeTableOption.desc}</option>
<#else>
<option value="${codeTableOption.itemCode}" title="${codeTableOption.desc}">${codeTableOption.desc}</option>
</#if>
</#list>
</#if>
</select>
