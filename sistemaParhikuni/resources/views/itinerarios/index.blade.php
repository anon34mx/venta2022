@extends('layouts.parhikuni')
@section('content')
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    @if (session('status'))
        <div class="alert alert-success alert-float-br">
            {{ session('status') }}
        </div>
    @endif

<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
    <h3>Itinerarios</h3>

    
    <div class="col-8 mx-auto">
        <a href="{{route('itinerarios.create')}}">
            <button>Nuevo</button>
        </a>
    </div>
    <div class="col-8 mx-auto">
        <table class="table table-parhi">
            <thead>
                <tr>
                    <th>Itinerario</th>
                    <th>Tramos</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                @php
                $itinerarios=$itinerarioClass::unicosDetallado();
                foreach($itinerarios as $itinerario){
                    //dd($itinerario[0]->id);
                    @endphp
                    <tr>
                        <td>{{$itinerario[0]->id}}</td>
                        <td colspan="1">
                            <ul style="list-style: none;">
                                @php
                                foreach($itinerario as $tramos){
                                    echo '<li class="text-left">'.$tramos->consecutivo.' - '.$tramos->origen.' <i class="fa-solid fa-arrow-right"></i> '.$tramos->destino.'</li>';
                                }
                                @endphp
                            </ul>
                        </td>
                        <td>
                            <a href="{{route('itinerarios.edit',$itinerario[0]->id)}}">
                                editar
                            </a>
                        </td>
                    </tr>
                    @php
                }


                /*
                    $last=null;
                    $itinerarios=$itinerarioClass::unicos();
                    $size=sizeof($itinerarios);
                    if(sizeof($itinerarios)>0){
                        for($i=0; $i<$size;$i++){
                            echo '<tr>
                                <td>'.$itinerarios[$i]["nItinerario"].'</td>
                                <td>'.$itinerarios[$i]["nConsecutivo"].'</td>
                                <td class="text-left">';
                                $tramos=new $itinerarioClass();
                                $tramos=$tramos->detalle($itinerarios[$i]->id);
                                dd($tramos);
                                foreach($tramos as $tramo){
                                    echo "<div class=''>".$tramo->origen." -> ".$tramo->destino."</div>";
                                }
                            echo '</td>
                                <td><a href="'.route('itinerarios.edit', $itinerarios[$i]['nItinerario']).'">
                                    <button>editar</button>
                                </a></td>
                            </tr>';
                        }
                    }*/
                @endphp
            </tbody>
        </table>
    </div>
</div>
@endsection