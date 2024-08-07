<%

On Error Resume Next

' Spam flag
Dim blnSpam

' Server verification
Dim intComp, strReferer, strServer

' Mail message
Dim sTo, sFrom, sName, sMail, sNumber, sDate, iSelect, sTour, sEnquiry, sMailBody, sReadReceipt, sMsg

' SMTP Host configuration
Dim oMail, oConfig, oConfigFields

CONST SMTPSendUsing = 2 ' Send using Port (SMTP over the network)
CONST SMTPServer = "websmtp.fasthosts.co.uk"

' For local testing only
' CONST SMTPServer = "localhost"

CONST SMTPServerPort = 25
CONST SMTPConnectionTimeout = 10 'seconds

blnSpam = False

' Check if this page is being called from a another page on the server
strReferer = Request.ServerVariables("HTTP_REFERER")
strServer = Replace(Request.ServerVariables("SERVER_NAME"), "www.", "")

intComp = inStr(strReferer, strServer)

If intComp = 0 Then
' Block spam attempt
	blnSpam = True
End If


'iSelect = Request.Form("frmtour")

'Select Case iSelect
	
	'Case 0
	
		'sTour = "No Tour Selected"
		 
	'Case 1
	
		'sTour = "Jane Austen"
		
	'Case 2
	
		'sTour = "Downton Abbey/Watership Down"
		
	'Case 3
	
		'sTour = "Hidden Hampshire"
				
	'Case 4
	
		'sTour = "Leadership & Group Tours"
		
	'Case 5
	
		'sTour = "Custom Tour"
		
	'Case Else
	
		'blnSpam = True
		
'End Select

sTour = "Jane Austen"

' Build mail message
If CStr(Request.Form("frmname")) = "" Then
' Block spam attempt
	blnSpam = True
Else
	sName = CStr(Request.Form("frmname"))
End If

If CStr(Request.Form("frmemail")) = "" Then
' Block spam attempt
	blnSpam = True
Else
	sMail = CStr(Request.Form("frmemail"))
End If

If Request.Form("frmnumber") = "" Then
   sNumber = "0"
Else
   sNumber = Request.Form("frmnumber")
End If

If Request.Form("frmdate") = "" Then
   sDate = "Not given"
Else
   sDate = Request.Form("frmdate")
End If

If CStr(Request.Form("frmcomments")) = "" Then
' Block spam attempt
	blnSpam = True
ElseIf InStr(CStr(Request.Form("frmcomments")), "http") Then
' Block spam attempt
	blnSpam = True
ElseIf InStr(CStr(Request.Form("frmcomments")), "feedback form") Then
' Block spam attempt
	blnSpam = True
Else
	sEnquiry = CStr(Request.Form("frmcomments"))
End If

' Redirect if spam flag set true
If blnSpam Then
	Response.Redirect "../pages/trap.html"
Else
	
	sTo = "info@hiddenbritaintours.co.uk"
	sFrom = "enquiries@hiddenbritaintours.co.uk"
	
	sMailBody = "Name: " & sName & vbCrLf & vbCrLf
	sMailBody = sMailBody & "E-mail: " & sMail & vbCrLf
	sMailBody = sMailBody & "Number In Party: " & sNumber & vbCrLf
	sMailBody = sMailBody & "Preferred Date: " & sDate & vbCrLf
	sMailBody = sMailBody & "Tour: " & sTour & vbCrLf
	sMailBody = sMailBody & "Enquiry: " & sEnquiry
	sMailBody = sMailBody & vbCrLf & vbCrLf
	
	sReadReceipt = true
	
	sMsg = sMailBody
	
	' Create CDO message object and SMTP host config
	Set oMail = Server.CreateObject("CDO.Message")
	Set oConfig = Server.CreateObject("CDO.Configuration")
	Set oConfigFields = oConfig.Fields
	
	With oConfigFields
		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = SMTPSendUsing
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTPServer
		.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = SMTPServerPort
		.Update
	End with
	
	oMail.Configuration = oConfig
	
	oMail.Subject = "Booking Enquiry: " & sTour
	oMail.To = sTo
	oMail.From = sFrom
	oMail.TextBody = sMsg
	
	' Send the mail
	oMail.Send
	
	' Clean up
	Set oMail = Nothing
	
		' Otherwise redirect to standard thank you page
		Response.Redirect "../pages/sent.html"

End If

' Redirect on error
If Err.Number <> 0  Then
	Response.Redirect "../pages/error.html"
End If

%> 
