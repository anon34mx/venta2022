<?php

namespace App\Models;

// use Illuminate\Database\Eloquent\Factories\HasFactory;
// use Illuminate\Database\Eloquent\Model;

class SMS 
{
    private $_soapClient = null;
    private $sms_client = "";
    private $sms_password = "";
    private $sms_sender = "";
    public function __construct()
    {
        $this->sms_client = env("SMS_CLIENT");
        $this->sms_password = env("SMS_PASSWORD");
        $this->sms_sender = env("SMS_SENDER");

        $this->_soapClient = new \nusoap_client("https://sms.innovatlmx.com/InnovattiaSMS/SendSMSWS?wsdl",true);
        $this->_soapClient->soap_defencoding = 'UTF-8';
    }
    //Aaron
    public function enviar_mensaje($texto,$numero){
        $aParametros=array(
            "usrClient"=>$this->sms_client,
            "pasClient"=>$this->sms_password,
            "sender"=>$this->sms_sender,
            "text"=>$texto,
            "gsm"=>$numero
        );
        try{
            $result = $this->_soapClient->call('SendSMS', $aParametros);
        }catch (SoapFault $fault){
            trigger_error("SOAP Fault: (faultcode: {$fault->faultcode}, faultstring: {$fault->faultstring})", E_USER_ERROR);
        }
        return $result;
    }
}
