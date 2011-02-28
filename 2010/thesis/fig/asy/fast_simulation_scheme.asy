unitsize(1cm);

real h = 2, p = 3, dscrw = 1;

draw((0, 0)--(0, h), black+1pt);
draw((-p, 0)--(-p, h), black+1pt);
draw((+p, 0)--(+p, h), black+1pt);

filldraw((-p/2-dscrw/2, 0)--(-p/2+dscrw/2, 0)--(-p/2+dscrw/2, h)--(-p/2-dscrw/2, h)--cycle, paleblue, nullpen);
filldraw((+p/2-dscrw/2, 0)--(+p/2+dscrw/2, 0)--(+p/2+dscrw/2, h)--(+p/2-dscrw/2, h)--cycle, paleblue, nullpen);

draw((-p/2, 0)--(-p/2, h), black+dashdotted);
draw((+p/2, 0)--(+p/2, h), black+dashdotted);
