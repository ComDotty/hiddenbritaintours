<%

'Dim strLangURL
'Dim strReferer

	'strLangURL = ""
	'strReferer = Request.ServerVariables("HTTP_REFERER")
	
	'If Instr(strReferer, ".fr") Then
	   'strLangURL = "https://www.hiddenbritaintours.co.uk/index_fr.html"
	'ElseIf Instr(strReferer, ".de") Then
	   'strLangURL = "https://www.hiddenbritaintours.co.uk/index_de.html"
	'Else
	   'strLangURL = "https://www.hiddenbritaintours.co.uk/index.asp"	
	'End If
	   
	'Response.Redirect strLangURL
	Response.Redirect "index.asp"

%>