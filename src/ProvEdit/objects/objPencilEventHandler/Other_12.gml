/// @description Clicking
var ox1 = x1, oy1 = y1
var kx, ky, c, i, xx, yy, dx, dy;

x1 -= x0
kx = 0
if (x1 > 0)
    kx = 1
else if (x1 < 0) {
    kx = -1
    x1 = -x1
}
x1++


y1 -= y0
ky = 0
if (y1 > 0)
    ky = 1
else if (y1 < 0) {
    ky = -1
    y1 = -y1
}
y1++

if (x1>=y1) {
    var c = x1;
    for (var i = 0; i < x1; i++) {
		event_user(4)
		c-=y1; 
        if (c<=0) {
            c+=x1; 
            y0+=ky; 
        }
      
        x0+=kx
    }
} else {
    var c = y1;
    for (i=0;i<y1;i++) {
		event_user(4)
		c-=x1;
        if (c<=0) {
            c+=y1;
            x0+=kx;
      
        }
        y0+=ky
    }
}

x0 = ox1
y0 = oy1