/*
 * ohgj78.prg by MikeDX
 * (c) 2016 DX Games
 */

PROGRAM ohgj78;

BEGIN

//Write your code here, make something amazing!
set_mode(640480);
load_fpg("ohgj78.fpg");

player(0,0,0,0);

LOOP
    roll_palette(1,254,1);
    FRAME;
END

END


PROCESS player(x,y,trail,size)

BEGIN
GRAPH=1;

IF(trail)
    flags=4;
    WHILE(size>0)
        size-=1;
        if(get_dist(smallbro)>5)
            xadvance(get_angle(smallbro),5);
        end
        FRAME;
    END
    RETURN;
ELSE

    LOOP
        x = mouse.x;
        y = mouse.y;
        size = 125+50*(sin(timer)/1000);
        player(x,y,1,size);

        FRAME;
    END
END

END

