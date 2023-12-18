// import './bootstrap';
// import { bindKey, bindKeyCombo } from '@rwh/keystrokes';

// window.bindKey = bindKey;
// window.bindKeyCombo = bindKeyCombo;

// Una tecla
// bindKey('f1', function (event) {
//     // event.originalEvent.preventDefault();
//     alert("F1");
// });
// Una tecla tras otra
// bindKeyCombo('c,r,e,d,i,t,o,s', function (event) {
//     //Añadirse en la siguiente línea
//     var txtCreditos=`
//         Jahaziel Aarón Aguilera Castillo 2023<br>
//         a.non34@hotmail.com
//         `;
//     $().screamer({
//         title: '<b>Créditos</b>',
//         message: txtCreditos,
//         button: 'cerrar',
//         theme: 'screamer-red',
//         overlayClose: false
//     });
// });
// Al mismo tiempo
// bindKeyCombo('t > e', function (event) {
//     alert("txtCreditos");
// });