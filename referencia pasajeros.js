function agregarPasajero(imgn){
	$("#btnAgregar").hide();
	// Evitar doble click
	setTimeout(function(){
		$("#btnAgregar").show();
	}, 400);
	//
	var idpas = $("#listPasajeros").val();
	//
	if (idpas != "")
	{
		// Se agrega imagen de pasajero tomando en cuenta si el asiento SELECCIONADO cuenta con TV/PANTALLA
		if (imgn.includes("asientoTeleOver.png") || imgn.includes("asientoTele.png"))
		{
			$("#" + posicionActiva).attr("src", "./imagenes/skin-parhikuni/bus/asientoSeleccionadoTV.png");
		}
		else
		{
			$("#" + posicionActiva).attr("src", "./imagenes/skin-parhikuni/bus/asientoSeleccionado.png");
		}
		//
		$("#" + campoBuscar).val(numAsiento);
		$("#icnCerrar").trigger("click");
		dispoPasTemp[idpas] = false;
		// Se agrega a arreglo asientos seleccionados
		if (corrida == 1)
		{
			// Se incrementa contador de asientos seleccionados
			asiento.V_PasajerosSel++;
			var tipoComparar = tipo;
			var asientoAgregar = $("#" + posicionActiva).attr("name");
			//
			$("#tbl-asientos").append(
				`<tr id="sel-${parseInt(asientoAgregar)}">
					<td class="hidden"><span class="idspas">${idpas}</span></td>
					<td class="asiento"><span class="numspas">${formatNumber(parseInt(asientoAgregar), 2)}</span></td>
					<td class="ubicacion">Ventana</td>
					<td class="nombre">${NombrePasTemp[idpas]}</td>
					<td style="text-align:center;"><button class="btnElimPas" onclick="btnElimPas(${parseInt(asientoAgregar)})">x</button></td>
				</tr>`
			);
			// Obtener datos de la tabla
			var a = $(".idspas");
			var b = $(".numspas");
			// Nuevas variables
			A_AsientosPasajeros = Array();
			// Se llenan las variables anteriores
			for (i = 0; i < a.length; i++)
			{
				console.log(a[i].textContent + "__" + b[i].textContent);
				A_AsientosPasajeros[a[i].textContent] = b[i].textContent;
			}
			A_AsientosPasajeros = Object.values(A_AsientosPasajeros);
		}
		else
		{
			// Se incrementa contador de asientos seleccionados
			asientoR.V_PasajerosSel++;
			var tipoComparar = tipo;
			var asientoAgregar = $("#" + posicionActiva).attr("name");
			//
			$("#tbl-asientos").append(
				`<tr id="sel-${parseInt(asientoAgregar)}">
					<td class="hidden"><span class="idspas">${idpas}</span></td>
					<td class="asiento"><span class="numspas">${formatNumber(parseInt(asientoAgregar), 2)}</span></td>
					<td class="ubicacion">Ventana</td><td class="nombre">${NombrePasTemp[idpas]}</td>
					<td style="text-align:center;"><button class="btnElimPas" onclick="btnElimPas(${parseInt(asientoAgregar)})">x</button></td>
				</tr>`
			);
			// Obtener datos de la tabla
			var a = $(".idspas");
			var b = $(".numspas");
			// Nuevas variables
			A_AsientosPasajerosRegreso = Array();
			// Se llenan las variables anteriores
			for (i = 0; i < a.length; i++)
			{
				console.log(a[i].textContent + "__" + b[i].textContent);
				A_AsientosPasajerosRegreso[a[i].textContent] = b[i].textContent;
			}
			A_AsientosPasajerosRegreso = Object.values(A_AsientosPasajerosRegreso);
		}
	}
	else
	{
		crearVentana("Seleccione un pasajero");
	}
}

function btnElimPas(param) {
	eliminarPasajero(param);
}

function eliminarPasajero(num) {
	if (num != undefined) {
		idAsiento = "pos" + num;
	}
	//evitar doble click
	$("#btnEliminar").hide();
	setTimeout(function () {
		$("#btnEliminar").show();
	}, 400);

	//Se elimina imagen y se restaura valor de asiento
	var cadenaTV = img[1].split("Seleccionado");

	if (cadenaTV == "asientoTele.png") {
		$("#" + idAsiento).attr("src", "./imagenes/skin-parhikuni/bus/asientoTele.png");
	} else if (cadenaTV[1] == "TV.png") {
		$("#" + idAsiento).attr("src", "./imagenes/skin-parhikuni/bus/asientoTele.png");
	} else {
		$("#" + idAsiento).attr("src", "./imagenes/skin-parhikuni/bus/asientolibre.png");
	}

	//El elemento borrado se agrega a la cadena pasajeros al principio
	//$("#"+campoAsiento).val("0");

	/*NombrePasTemp.unshift(etiquetaNombre[1]);
	tipoPasTemp.unshift(numeroPasajero);*/

	//Se elimina de arreglo de asientos el lugar seleccionado
	//$("#sel-30").children()[0].innerText
	////console.log( $("#sel-"+idAsiento.substring(3)).children()[0].innerText );
	dispoPasTemp[parseInt($("#sel-" + idAsiento.substring(3)).children()[0].innerText)] = true;
	//Se eliminar de la tabla de asientos seleccionados
	$("#sel-" + idAsiento.substring(3)).remove();

	//var tipoBorrar = cadenaTV[0]; //Ej. asientoInsen
	var tipoBorrar = cadenaTV[0].substring(7, cadenaTV[0].length); //Se obtiene tipo de pasajero
	var asientoBorrar = $("#" + idAsiento).attr("name");

	if (corrida == 1) {
		for (x in tipoPas) {
			if (tipoPas[x] == tipoBorrar && A_AsientosPasajeros[x] == asientoBorrar) {
				A_AsientosPasajeros[x] = "";
				tipoBorrar = "TEST";
			}
		}
	} else {
		for (x in tipoPas) {
			if (tipoPas[x] == tipoBorrar && A_AsientosPasajerosRegreso[x] == asientoBorrar) {
				A_AsientosPasajerosRegreso[x] = "";
				tipoBorrar = "TEST";
			}
		}
	}

	if (corrida == 1) {
		//Se decrementa contador de asientos seleccionados
		asiento.V_PasajerosSel--;
		$(".pasajerosRegistrados").val('0');
	} else {
		asientoR.V_PasajerosSel--;
		$(".pasajerosRegistrados").val('0')
	}
	$("#icnCerrar").trigger("click");

}