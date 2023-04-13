import './bootstrap';
import { bindKey, bindKeyCombo } from '@rwh/keystrokes';

window.bindKey = bindKey;
window.bindKeyCombo = bindKeyCombo;

// Una tecla
bindKey('f1', function (event) {
    event.originalEvent.preventDefault();
});
// Una tecla tras otra
bindKeyCombo('c,r,e,d,i,t,o,s', function (event) {
    //Añadirse en la siguiente línea
    const txt="Creditos\nJahaziel Aarón Aguilera Castillo\na.non34@hotmail.com\n2023";
    alert(txt);
});
// Al mismo tiempo
bindKeyCombo('t > e', function (event) {
    alert("txt");
});