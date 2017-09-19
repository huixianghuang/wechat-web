/**
 * Created by Programmer on 2017/7/15.
 */
var a = str.split(/\x28|\x29/)


function calculate(str) {
    var t = str.slice(0, 3);
    var count = 0;

    for (var i=4; i<str.length; i++) {
        if (str[i] == ',') {
            count = i;
            break;
        }
    }

    var spl = [];
    spl[0] = str.slice(4, count);
    spl[1] = str.slice(count+1, -1);

    return d(t, spl[0], spl[1]);


}