<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boleto - parhikuni</title>
    <style>
        :root {
            --main-bg-color: brown;
            --color1: {{$color}};
        }

        @font-face {
            font-family: "sans-serif";
            font-weight: normal;
            font-style: normal;
            src: url({{ Vite::asset('/fonts/OpenSans-Regular.ttf') }});
        }

        *{
            padding: 0px;
            margin: 0px;
            line-height:1;
            font-family: "sans-serif";
            pointer-events:none;
        }
        html{
            background: lightgray;
        }
        body{
            padding:0.3cm;
            width: 21.6cm;
            height:27.94cm;
        }
        .boleto{
            background:white;
            width: 21.0cm;
            height: 27.34cm;
        }
        .contenedor{
            height: 9.7cm;
            width: 21cm;
            position: relative;
        }
        .contenedor .legal{
            width:11.3cm;
            height: 9.5cm;
            border: 0.1cm solid {{$color}};
            border-radius: 0.5cm 0.5cm 0.5cm 0.5cm;
        }
        .contenedor .legal span{
            color:white;
            position: relative;
            top: 4.6cm;
            left: -4.6cm;
            transform: rotate(-90deg);
            background: {{$color}};
            width: 9.4cm;
            padding:0.1cm;
            display: inline-block;
            font-weight: bold;
            text-transform: uppercase;
            text-align: center;
            border-radius: 0.5cm 0.5cm 0 0;
        }
        .contenedor .legal .condiciones{
            position: relative;
            width: 10.7cm;
            left: 0.55cm;
            top: -22px;
            line-height: 0.9;
            font-size: 10.1px;
        }
        .contenedor .datos{
            width:9.3cm;
            height: 9.5cm;
            border: 0.1cm solid {{$color}};
            border-radius: 0.5cm 0.5cm 0.5cm 0.5cm;
            position: absolute;
            top:0cm;
            left:11.5cm;
        }
        .contenedor .datos .logo-bar{
            background: {{$color}};
            height:1.2cm;
            width:9.3cm;
            border-radius:12px 0 0 0;
            border-radius: 0.2cm 0.2cm 0 0;
        }
        .contenedor .datos .logo-bar img{
            position: relative;
            height:0.7cm;
            left:0.4cm;
            top:0.2cm;
        }
        .contenedor .datos .logo-bar .nit{
            position: relative;
            width: 4cm;
            left: 5.0cm;
            top: -0.4cm;
            font-size:14px;
            text-align:right;
            color: white;
        }
        .contenedor .origen-destino{
            line-height: 1.1;
            padding: 0.1cm 0 0 0;
            width: 9.3cm;
            top:1.3cm;
            height: auto;
            position: absolute;
            display:block;
            text-align:center;
            font-size: 12px;
        }
         .origen{
            width: 50%;
            float:left;
            text-transform:uppercase;
        }
         .destino{
            width: 50%;
            float:left;
            text-transform:uppercase;
        }
        .contenedor .separador{
            position: absolute;
            left: 33.33%;
            width: 33.33%;
            height: 3px;
            background: {{$color}};
            top: 2.1cm;
        }
        .contenedor .origen-destino-lbl{
            font-size:10px;
            width: 9.3cm;
            height: auto;
            position: absolute;
            left: 0cm;
            top: 2.3cm;
            display: block;
            text-align:center;
        }
        .contenedor .salida{
            font-size: 12px;
            text-align:center;
            text-transform: uppercase;
            top: 3.0cm;
        }
        .contenedor .claseServicio{
            position:relative;
            top:0.2cm;
            text-align:center;
            font-size:12px;
            font-weight:bold;
            text-transform: uppercase;
            color:{{$color}};
        }
        .contenedor .pasajero{
            position:relative;
            font-size: 12px;
            text-align:center;
            text-transform: uppercase;
            top: 0.6cm;
            font-size: 13px;
        }
        .datospago{
            width: 100%;
            font-size: 12px;
            line-height:1.1;
            position: relative;
            top:1cm;
        }
        .datospago tr td:first-child{
            width: 50;
            text-align:right;
            padding-right:2px;
        }
        .datospago tr td:nth-child(2){
            width: 50;
            text-align:left;
            padding-left:2px;
        }
        .codbar-cont{
            text-align:center;
            position:relative;
            top: 1.7cm;
            height:1.4cm;
        }
        .codbar-cont img{
            width:4cm;
            height:0.9cm;
        }
        .codbar-cont .boletoID{
            position:relative;
            top:0.05cm;
            height:0.4cm;
            width: 100%;
            padding: 0;
        }
        .tipoPuntoVenta{
            position:absolute;
            top:9.15cm;
            right:0.6cm;
            font-size:12px;
            text-align:right;
            text-transform: uppercase;
        }
        .boleto .corteLinea,
        .boleto .facturacion{
            height: 0.75cm;
        }
        .boleto .corteLinea{
            background: url({{ Vite::asset('resources/images/Boletos/2020_porNadia/cut-line.png') }});
            background-repeat: repeat-x;
            background-position: center;
        }
        .boleto .tijeras{
            height: 0.5cm;
            top:0.1cm;
            position: relative;
            left: 0.1cm;
        }
        .boleto .facturacion{
            font-weight: bold;
            font-size: 11px;
            line-height: 1.0;
            padding: 0.06cm;
        }
        .banner{
            display:block;
            background:yellow;
            width: 21.0cm;
        }
    </style>
</head>
<body>
    @for($contBol=0; $contBol<sizeof($boletos); $contBol++)
        <div id="" class="boleto">
            @for($i=0; $i<2;$i++)
                <div class="contenedor">
                    <div class="legal">
                        @if($i==0)
                            <span>Copia del conductor</span>
                        @else
                            <span>Copia del cliente</span>
                        @endif
                        <div class="condiciones">
                            <b>1.</b> Sírvase conservar este boleto hasta el término de su viaje ya que le da derecho al seguro del viajero y a 25 kilos de equipaje sin costo, condicionado al volumen de carga y a la capacidad del autobús.
                            <br>
                            <b>2.</b> Este boleto es válido únicamente para la hora y fecha anotados en el mismo, verifíquese al adquirirlo, porque no hay cancelaciones en esta modalidad de compra.
                            <br>
                            <b>3.</b> Boletos adquiridos con descuento (Estudiantes, Maestros, Discapacitados, Menor, IMSS, ISSTE, INAPAM, INM, etcétera) no son canjeables, ni transferibles, ni cancelables.
                            <br>
                            <b>4.</b> Si desea realizar algún cambio en este boleto, sólo podrá efectuarlo en taquillas y/o puntos de venta directos, antes del día y hora de salida, presentado una identificación oficial además del boleto. (30 minutos antes de su salida) .
                            <br>
                            <b>5.</b> La empresa no se responsabiliza por equipajes no documentados, sin talón o por bultos u otras pertenencias de mano que el pasajero lleve consigo en el interior del autobús.
                            <br>
                            <b>6.</b> En caso de perdida y/o extravió de equipaje documentado o registrado, se pagara una indemnización hasta por el equivalente a 15 veces de salario mínimo general vigente en la cdmx, de conformidad con lo dispuesto por el artículo 66 fracción V, de la Ley de Caminos, Puentes y Autotransporte Federal.
                            <br>
                            <b>7.</b> Queda estrictamente prohibido transportar como equipaje explosivos, sustancias tóxicas, enervantes, psicotrópicas o peligrosas, piezas de arte o arqueológicas, materiales inflamables, instrumentos o títulos negociables o al portador, materiales obscenos o pornográficos, animales, objetos de fácil descomposición o de mal olor, productos perecederos, y en general todo artículo prohibido por la ley o que requiera de permiso especial, así como cualquier envío que requiera de declaración aduanal o permiso de importación. Al efecto, DESTINOS PARHIKUNI, S.A. DE C.V., se reserva el derecho de revisar el equipaje que transporta el pasajero y se deslinda de toda responsabilidad por la Total: $65.00 transportación de materiales, sustancias y objetos que se prohíben de manera enunciativa, no así limitativa.
                            <br>
                            <b>8.</b> Los alcances del presente consumo quedan regulados por las leyes y reglamentos Mexicanos aplicables en la materia, así como por todas y cada una de las cláusulas contenidas en el boleto de sistema y/o autorizado por las autoridades competentes.
                            <br>
                            <b>9.</b> El pasajero admite y reconoce la validez de las leyes y reglamentos Mexicanos y competencia de los tribunales del mismo país, por lo que se somete expresamente a la jurisdicción de los Tribunales del Fuero Común y/o Federales con sede en la Ciudad donde se ubica el domicilio matriz y fiscal de DESTINOS PARHIKUNI, S.A. DE C.V., situado en Morelia, Michoacán, renunciando a aquél que pudiere corresponderle en razón de su domicilio presente o futuro
                            <br>
                        </div>
                    </div>
                    <div class="datos">
                        <div class="logo-bar">
                            <img class=""
                                src="{{ Vite::asset('resources/images/logo_parhikuni_blanco.png') }}">
                            <div class="nit">
                                FOLIO
                                <br>
                                <b>{{$venta->nNumero}}</b>
                            </div>
                        </div>
                        <div class="origen-destino">
                            <div class="origen">
                                <b>
                                    {{$boletos[$contBol]->origen->aNombre}}
                                </b>
                                <BR>
                                {{$boletos[$contBol]->origen->aEntidad}}
                            </div>
                            <div class="destino">
                                {{$boletos[$contBol]->destino->aNombre}}
                                <BR>
                                {{$boletos[$contBol]->destino->aEntidad}}
                            </div>
                        </div>
                        <div class="separador"></div>
                        <div class="origen-destino-lbl">
                            <div class="origen">ORIGEN</div>
                            <div class="destino">DESTINO</div>
                        </div>
                        <div class="salida">
                            SALIDA
                            <!-- 
                                j - dia numerico del nes
                                S - complemento del numero de dia (first)st, (second)nd, th, °
                                l - dia
                                d - dia abreviado
                                M - mes (abreviado)
                                F - mes (completo)
                                m - minutos
                                Y - año
                                H - horas
                                i - minutos
                             -->
                            @php
                                $fSalida=\Carbon\Carbon::parse($boletos[$contBol]->fSalida." ".$boletos[$contBol]->hSalida);
                                $format1 = 'l, j \\de F \\de Y';
                                $format2 = 'H:i';
                            @endphp
                            <b>
                                {{$fSalida->translatedFormat($format1)}}
                                <br>
                                a las {{$fSalida->translatedFormat($format2)}}
                            </b>
                        </div>
                        <div class="claseServicio">
                            SERVICIO {{$boletos[$contBol]->corrida->servicio->aDescripcion}}
                        </div>
                        <div class="pasajero">
                            <b>PASAJERO</b>
                            <span>{{$boletos[$contBol]->aPasajero}}</span>
                        </div>
                        <table class="datospago">
                            <tr>
                                <td>TIPO:</td>
                                <td>{{$boletos[$contBol]->tipo->aDescripcion}}</td>
                            </tr>
                            <tr>
                                <td>asiento:</td>
                                <td>{{$boletos[$contBol]->nAsiento}}</td>
                            </tr>
                            <tr>
                                <td>forma de pago:</td>
                                <td>
                                    @php
                                    $auxfp=sizeof((array)$boletos[$contBol]->venta->pagos);
                                        for($bfp=0; $bfp<$auxfp; $bfp++){
                                            echo @$boletos[$contBol]->venta->pagos[$bfp]->aFormaPago." ";
                                            if($bfp>=4){
                                                break;
                                            }
                                        }
                                    @endphp
                                </td>
                            </tr>
                            <tr>
                                <td>subtotal:</td>
                                <td>${{$boletos[$contBol]->nMontoBase}}</td>
                            </tr>
                            <tr>
                                <td>iva:</td>
                                <td>${{$boletos[$contBol]->nIVA}}</td>
                            </tr>
                            <tr>
                                <td>total:</td>
                                <td>${{$boletos[$contBol]->nMontoBase + $boletos[$contBol]->nIVA}}</td>
                            </tr>
                        </table>
                        <div class="codbar-cont">
                            <img src="data:image/png;base64, {{$boletos[$contBol]->codbar}}" alt="barcode"/>
                            <div class="boletoID">
                                {{$boletos[$contBol]->nNumero}}
                            </div>
                        </div>
                        <div class="tipoPuntoVenta">
                            {{$tipoPuntoVenta}}
                        </div>
                    </div>
                </div>
                @if($i==0)
                    <div class="corteLinea">
                        <img class="tijeras"
                            src="{{ Vite::asset('resources/images/Boletos/2020_porNadia/cut_here.png') }}">
                    </div>
                @else
                    <div class="facturacion">
                        DESTINOS PARHIKUNI S.A. DE C.V. 27603587. MARTING MONGE #112 COL. NUEVA VALLADOLID, C.P. 58189, MORELIA, MICHOACÁN. RFC DPA1910303P4. "CONTRIBUYENTE DEL RÉGIMEN SIMPLIFICADO" "EFECTOS FISCALES AL PAGO" {{date("Y-m-d H:i:s")}}
                    </div>
                @endif
            @endfor
            <img src="{{ Vite::asset('resources/images/Boletos/2020_porNadia/banners/default.jpg') }}"
                alt="banner" class="banner">
        </div>
    @endfor
</body>
</html>