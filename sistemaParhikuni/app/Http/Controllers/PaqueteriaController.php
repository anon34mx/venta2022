<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CorridasDisponibles;
use App\Models\Oficinas;
use App\Models\Paqueteria;

use Carbon\Carbon, DB;

class PaqueteriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('paqueteria.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // $oficinas=Oficinas::where("lDestino", "=", true);
        // dd(Paqueteria::getFactoresPaq());
        return view('paqueteria.create',[
            "estados" => $this->estados(),
            "oficinas" => Oficinas::where("lDestino", "=", true)->get(),
            "factores" => Paqueteria::getFactoresPaq()
            // "destinos" => Oficinas::destinos(1, false),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function asentamientos(Request $request){
        $sql='SELECT
                tipAs.nombre as tipoAsentamiento,
                asen.d_codigo as cp, asen.d_asenta as asentamiento,
                edo.id estado_id, edo.nombre estado, edo.abrev as abrev,
                mun.clave municipio_clave, mun.clave, mun.nombre municipio,
                IFNULL(cds.id, "") as ciudad_id, IFNULL(cds.nombre, "") ciudad,
                MATCH (asen.d_asenta) AGAINST ("Aldana" IN NATURAL LANGUAGE MODE) as score
                
                From cat_ageeml.asentamientos asen
                
                INNER JOIN cat_ageeml.cat_tipo_asentamiento as tipAs
                ON tipAs.id=asen.tipo_asentamiento_id
                
                INNER JOIN cat_ageeml.estados edo
                ON edo.id=asen.estado_id
                
                INNER JOIN cat_ageeml.municipios mun
                ON mun.clave=asen.municipio_clave AND mun.estado_id=edo.id
                
                LEFT JOIN cat_ageeml.ciudades cds
                ON cds.id=asen.ciudad_id AND cds.estado_id=edo.id AND mun.clave=asen.municipio_clave
                
                WHERE
                edo.nombre=:EDO AND mun.nombre=:municipio
                AND MATCH (asen.d_asenta) AGAINST (:asentamiento IN NATURAL LANGUAGE MODE)
                ORDER BY edo.id, mun.clave, asen.d_asenta';

        $rs=DB::select(
            $sql,[
                "asentamiento" => $request->asentamiento." ",
                "municipio" => $request->municipio,
                "EDO" => $request->estado
            ]
        );
        return json_encode($rs);
    }
    public function estados(){
        $rs=collect(
            DB::select(
                DB::raw('SELECT
                    edo.id, edo.nombre, edo.abrev
                    FROM cat_ageeml.estados edo
                    ORDER BY edo.id ASC'
                )
            )
        );
        return $rs;
    }

    public function getCorridas(){
        // sólo corridas, independientemente de la ocupación
        $fInicio = Carbon::now();
        $fFin = Carbon::now()->addHours(24);

        $cd = new CorridasDisponibles();
        $cd=$cd->filtrar(null, 8, null, $fInicio->format("Y-m-d"), null, null, 
            "12:00:00", null, null, 15, "rango");
        return $cd;
        /* [JS]
        
        const promise=fetch(route("paqueteria.corridas.filtrar",[8,10]))
        .then(response => response.text())
        .then(data => {
            $("#cordis tbody").empty();
            data=JSON.parse(data);
            console.log(data);

            for(i=0; i<data.length; i++){
                $("#cordis").append(`
                    <tr>
                        <td>${data[i].corrida}</td>
                        <td>${data[i].origen}</td>
                        <td>${data[i].destino}</td>
                        <td>${data[i].hSalida}</td>
                        <td>${data[i].hLlegada}</td>
                    </tr>
                `);
            }
        });
        */
    }

    public function buscarRemitente(Request $request){
        // ya no me acuerdo por qué hice esto
        $params = array();
        parse_str($request[0], $params);
        // dd($params);
        // /*
            $sql='SELECT * FROM remitentes WHERE
                CURP="AUCJ941217HMNGSH06" OR 
                RFC="AUCJ941217S61" OR
                correo="aaron.aguilera@parhikuni.mx" OR
                telefono1="4432443657" OR
                telefono2="4432443657" OR
                MATCH (nombres, apellidos, correo)
                AGAINST ("auCJ" IN NATURAL LANGUAGE MODE)';
        $res = array();
        $stmt;
        $sql='SELECT * FROM remitentes WHERE ';
        if(isset($params["id_remitente"])){
            $sql.= "id=?";
            $res=DB::raw($sql);
            $res=DB::select($res, [$params["id_remitente"]]);
        }else{
            if( isset($params["rem_CURP"]) ){
                $sql.="CURP='${params['rem_CURP']}' OR ";
            }
            if( isset($params["rem_RFC"]) ){
                $sql.="RFC='${params['rem_RFC']}' OR ";
            }
            if( isset($params["rem_correo"]) ){
                $sql.="correo='${params['rem_correo']}' OR ";
            }
            if( isset($params["rem_telefono1"]) ){
                $sql.="telefono1='${params['rem_telefono1']}' OR ";
            }
            if( isset($params["rem_telefono2"]) ){
                $sql.="telefono2='${params['rem_telefono2']}' OR ";
            }
            $sql.=" MATCH (nombres, apellidos, correo) AGAINST ('".@$params['rem_nombres']." ".@$params['rem_apellidos']."' IN NATURAL LANGUAGE MODE)";
            $res=DB::select(DB::raw($sql));
        }
        if(sizeof($res)>0){
            foreach ($res as $rem) {
                // dd($rem);
                ?>
                <div class="mt-3 border border-primary rounded" onclick="usarRemitente(this);">
                    <table class="remitente-card mx-0 my-0">
                        <tr class="hidden">
                            <td>ID</td>
                            <td><span class="" target="#ID_REMITENTE" ><?=$rem->id?></span></td>
                            
                        </tr>
                        <tr>
                            <td>Nombres</td>
                            <td colspan="3"><b> <span class="" target="#rem_nombre" ><?=$rem->nombres?> </span></b> <b> <span class="" target="#rem_apellidos" ><?=$rem->apellidos?> </span></b></td>
                        </tr>
                        <tr>
                            <td>RFC</td>
                            <td><b> <span class="" target="#rem_RFC" ><?=$rem->RFC?> </span></b></td>
                            <td>CURP</td>
                            <td><b> <span class="" target="#rem_CURP" ><?=$rem->CURP?> </span></b></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><span class="hidden" target="#rem_ciudad"><?=$rem->ciudad?></span></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <span class="" target="#rem_calle"><?=$rem->calle?></span>, #<span class="" target="#rem_num_ext"><?=$rem->numExt?></span> <span class="" target="#rem_num_int"><?=$rem->numInt?></span>
                                <span class="" target="#rem_asentamiento" ><?=$rem->colonia?></span>, 
                                <span class="" target="#rem_cp" ><?=$rem->CP?></span>, 
                                <span class="" target="#municipio" ><?=$rem->municipio?></span>, 
                                <span class="" target="rem_estado" ><?=$rem->estado?></span>, <span class="" target="#rem_pais"><?=$rem->pais?></span>
                            </td>
                        </tr>
                        <tr>
                            <td>telefono1</td>
                            <td><span class="" target="#rem_telefono1" ><?=$rem->telefono1?></span></td>
                            <td>telefono2</td>
                            <td><span class="" target="#rem_telefono2" ><?=$rem->telefono2?></span></td>
                        </tr>
                        <tr>
                            <td>correo</td>
                            <td><span class="" target="#rem_correo"><?=$rem->correo?></span></td>
                        </tr>
                    </table>
                </div>
                <?php
            }
        }else{
            ?>
            <div class="mt-3 border border-primary">
                No se encontraron resultados
            </div>
            <?php
        }
    }

    public function listaProductosSAT($buscar){
        return Paqueteria::getListContenidoPaquete($buscar);
    }
    public function getFactoresPaq(){
        // dd();
    }
}