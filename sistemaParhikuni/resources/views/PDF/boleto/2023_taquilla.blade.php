<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script></script>
        @vite([
        'resources/sass/app.scss',
        'resources/js/app.js',
    ])
    <style>
        *{
            padding: 0px;
            margin: 0px;
            line-height:1;
            font-family: "sans-serif";
            pointer-events:none;
        }
        html{
        }
        body{
            width: 101mm;
            height:300mm;
            max-width: 101mm;
            max-height:300mm;
        }
        div{
        }

        .cont{
            width: 100%;
            min-height:1cm;
        }
        #titulo{
            display:block;
            width: 101mm;
            height: 1cm;
        }
        #titulo #logo{
            width: 50%;
            float:left;
            height: 1cm;
        }
        #titulo #logo img{
            width:auto;
            height:auto;
            max-height:1cm;
            position: absolute;
            margin-left:3mm;
            margin-top:2mm;
        }
        #titulo .boletos{
            width: 50%;
            height: 1cm;
            float:right;
            text-align:right;
            margin-left:3mm;
            margin-top:2mm;
        }
        #titulo .boletos span{
            display: block;
            font-size: 24px;
            width:4.5cm;
            height: 0.8cm;
            margin-top:0.2cm;
        }

        .qr{
            width: 10.1cm;
            height:28mm;
            display:contents;
            position: relative;
        }
        .qr img{
            display:block;
            position:absolute;
            left:50%;
            transform: translateX(-50%);
        }
        #datosventa{
            width:100%
        }
        #datosventa tr td{
            width:50%;
        }
        #datosventa tr td:nth-child(1){
            text-align:right;
            padding-right:5px;
        }
        #datosventa tr td:nth-child(2){
            padding-left:5px;
            font-weight:bold;
        }
        </style>
</head>
<body>
    <div id="titulo" class="cont">
        <div id="logo">
            <img id="logo" class="col-6" src="{{ Vite::asset('resources/images/logo_parhikuni.png') }}">
        </div>
        <div class="boletos">
            <span>
                Boletos
            </span>
        </div>
    </div>
    <br>
    <div class="qr">
        <img src="data:image/png;base64, {{$venta->codbar}}" alt="barcode"/>
    </div>
    @php
        $fSalida=\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", $boletos[0]->fSalida." ".$boletos[0]->hSalida);
        $bols=sizeof($boletos);
    @endphp
    <table id="datosventa">
        <tr>
            <td>FOLIO</td>
            <td>{{$venta->nNumero}}</td>
        </tr>
        <tr>
            <td>ORIGEN</td>
            <td>{{$boletos[0]->origen->aNombre}}</td>
        </tr>
        <tr>
            <td>DESTINO</td>
            <td>{{$boletos[0]->destino->aNombre}}</td>
        </tr>
        <tr>
            <td>FECHA</td>
            <td>{{$fSalida->format("Y-m-d")}}</td>
        </tr>
        <tr>
            <td>REGRESO</td>
            <td>{{$fSalida->format("H:i")}}</td>
        </tr>
        <tr>
            <td>BOLETOS</td>
            <td>{{sizeof($boletos)}}</td>
        </tr>
        <tr>
            <td>ASIENTOS</td>
            <td>
                @for($i=0; $i <$bols ; $i++)
                    @if($i<$bols-1)
                        {{$boletos[$i]->nAsiento.","}}
                    @else
                        {{$boletos[$i]->nAsiento}}
                    @endif
                @endfor
            </td>
        </tr>
    </table>
        
    <br>
    <br>
    <div style="font-size:12px;padding: 0 2mm;">
        <center>
            
        </center>
    </div>
    <div style="font-size:12px;padding: 0 2mm; text-align: justify;">
        <b>1</b>. Sírvase conservar este boleto hasta el término de su viaje ya que le da derecho al
        seguro del viajero y a 25 kilos de equipaje sin costo, condicionado al volumen de carga y
        a la capacidad del autobús.
        <b>2</b>. Este boleto es válido únicamente para la hora y fecha anotados en el mismo,
        verifíquese al adquirirlo, porque no hay cancelaciones en esta modalidad de compra.
        <b>3</b>. Boletos adquiridos con descuento (Estudiantes, Maestros, Discapacitados, Menor,
        IMSS, ISSTE, INAPAM, INM, etcétera) no son canjeables, ni transferibles, ni cancelables.
        <b>4</b>. Si desea realizar algún cambio en este boleto, sólo podrá efectuarlo en taquillas y/o
        puntos de venta directos, antes del día y hora de salida, presentado una identificación
        oficial además del boleto. (30 minutos antes de su salida) .
        <b>5</b>. La empresa no se responsabiliza por equipajes no documentados, sin talón o por
        bultos u otras pertenencias de mano que el pasajero lleve consigo en el interior del
        autobús.
        <b>6</b>. En caso de perdida y/o extravió de equipaje documentado o registrado, se pagara una
        indemnización hasta por el equivalente a 15 veces de salario mínimo general vigente en
        la cdmx, de conformidad con lo dispuesto por el artículo 66 fracción V, de la Ley de
        Caminos, Puentes y Autotransporte Federal.
        <b>7</b>. Queda estrictamente prohibido transportar como equipaje explosivos, sustancias
        tóxicas, enervantes, psicotrópicas o peligrosas, piezas de arte o arqueológicas, materiales
        inflamables, instrumentos o títulos negociables o al portador, materiales obscenos o
        pornográficos, animales, objetos de fácil descomposición o de mal olor, productos
        perecederos, y en general todo artículo prohibido por la ley o que requiera de permiso
        especial, así como cualquier envío que requiera de declaración aduanal o permiso de
        importación. Al efecto, DESTINOS PARHIKUNI, S.A. DE C.V., se reserva el derecho de
        revisar el equipaje que transporta el pasajero y se deslinda de toda responsabilidad por la
        Total: $65.00 transportación de materiales, sustancias y objetos que se prohíben de
        manera enunciativa, no así limitativa.
        <b>8</b>. Los alcances del presente consumo quedan regulados por las leyes y reglamentos
        Mexicanos aplicables en la materia, así como por todas y cada una de las cláusulas
        contenidas en el boleto de sistema y/o autorizado por las autoridades competentes.
        <b>9</b>. El pasajero admite y reconoce la validez de las leyes y reglamentos Mexicanos y
        competencia de los tribunales del mismo país, por lo que se somete expresamente a la
        jurisdicción de los Tribunales del Fuero Común y/o Federales con sede en la Ciudad
        donde se ubica el domicilio matriz y fiscal de DESTINOS PARHIKUNI, S.A. DE C.V.,
        situado en Morelia, Michoacán, renunciando a aquél que pudiere corresponderle en razón
        de su domicilio presente o futuro
    </div>
    <div style="text-align:right;margin-top:2mm; padding:0 3mm;font-size:12px;">
        IMPRESO {{date("Y-m-d h:i:s")}}
    </div>
</body>
</html>