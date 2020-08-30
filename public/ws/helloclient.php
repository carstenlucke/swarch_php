<?php
/**
 * Created by IntelliJ IDEA.
 * User: clucke
 * Date: 10.01.18
 * Time: 03:27
 */

const WS_HOST = "host.docker.internal";
const WS_PORT = "9999";

$client = new SoapClient("http://" . WS_HOST . ":" . WS_PORT . "/helloworld?wsdl");

var_dump($client->__getFunctions());
var_dump($client->__getTypes());

var_dump($client->sayHelloWorldFrom(["arg0" => "Carsten"]));