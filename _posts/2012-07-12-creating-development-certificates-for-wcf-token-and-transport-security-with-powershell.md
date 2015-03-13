---
title: Creating Development Certificates for WCF Token and Transport Security (with PowerShell)
author: Jamie
layout: blog-post
permalink: /2012/07/12/creating-development-certificates-for-wcf-token-and-transport-security-with-powershell/
categories:
  - Uncategorized
---
When developing WCF services that interact with a custom Security Token Service (STS), you will need to create at least one X.509 certificate. If you have access to a trusted certificate authority – e.g. a Windows Active Directory domain – then this task is pretty simple. But if you don’t, or maybe you would just rather create a set of self-signed certificates, here is an approach that works well for me.

This particular scenario utilizes **three separate certificates**. The first one is named “localhost” and is used to create an HTTPS binding in IIS 7.5. The other two certificates are used to sign and encrypt the security token created by our custom STS. Note that the certificate used for the HTTPS binding is called “localhost” so that running the sites on our laptops will always be valid – since the host name of the local development sites will always be “localhost”.

The PowerShell script below essentially uses MakeCert to create the issuer certificate – which is the one called “localhost”. Then we import that certificate into the LocalMachine Trusted Root store, so that we can use it as a trusted issuer and signer of the other two certificates. When using MakeCert to create the other two certificates, we use the –in, –ir, and –is arguments to tell MakeCert to sign them with the “localhost” certificate we created (and that is now fully trusted since we imported it into the Trusted Root store).

&nbsp;  


<pre>$issuerCertificate = "localhost"
$tokenCertificates = "TokenSigningCert", "TokenEncryptingCert"

$makecert = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\makecert.exe'
$certmgr = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\Bin\certmgr.exe'

function CreateIssuerCertificate {
    param($certificateSubjectName)

    $exists= ls cert:\LocalMachine\My | select subject | select-string "cn=$certificateSubjectName"
    if($exists -ne $null)
    {
        echo "$certificateSubjectName certificate already exists"
    }
    else
    {
        ls $env:temp\$certificateSubjectName.* | del
        & $makecert -r -pe -n "cn=$certificateSubjectName" -ss My -sr LocalMachine -sky exchange -sy 12 "$env:temp\$certificateSubjectName.cer"
        & $certmgr -add -c "$env:temp\$certificateSubjectName.cer" -s -r localmachine root
    }
}

function CreateTokenCertificate {
    param($certificateSubjectName, $issuerCertificateSubjectName)

    $exists= ls cert:\LocalMachine\My | select subject | select-string "cn=$certificateSubjectName"
    if($exists -ne $null)
    {
        echo "$certificateSubjectName certificate already exists"
    }
    else
    {
        & $makecert -pe -n "cn=$certificateSubjectName" -ss My -sr LocalMachine -sky exchange -sy 12 -in "$issuerCertificateSubjectName" -ir LocalMachine -is My "$env:temp\$certificateSubjectName.cer"
    }
}

CreateIssuerCertificate $issuerCertificate

foreach($cert in $tokenCertificates)
{
    write-host "Creating certificate $cert (signed by $issuerCertificate)"
    CreateTokenCertificate $cert "$issuerCertificate"
}</pre>