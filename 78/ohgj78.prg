/*
 * ohgj78.prg by MikeDX
 * (c) 2016 DX Games
 */

PROGRAM ohgj78;

GLOBAL
font;
fontbig;
splash;
playing;
score;
hiscore;
time;
intro = true;
sound_right;
sound_wrong;
music;

LOCAL
hit;

BEGIN

//Write your code here, make something amazing!
set_mode(640480);
file = load_fpg("ohgj78.fpg");
put_screen(file,14);

font = load_fnt("limejam.FNT");
fontbig = load_fnt("limejambig.FNT");
splash = load_wav("ohgjsplash.wav",0);
sound_right = load_wav("right.wav",0);
sound_wrong = load_wav("wrong.wav",0);
music = load_wav("piano.ogg",1);

//player(0,0,0,100);

if(intro)
    write(font,320,0,1,"ONE HOUR LIME JAM");
    playing = sound(splash,256,256);
    timer[0]=0;
    while(timer[0]<200)
        FRAME;
    END

    write(fontbig,320,140,1,"LIME JAM!");

    while(is_playing_sound(playing))
     //   roll_palette(1,254,1);
        FRAME;
    END
end

sound(music,256,256);


LOOP

fade_off();

WHILE(fading)
FRAME;
END

delete_text(all_text);

fade_on();

//end

write(font,320,0,1,"LIME SPOTTER!");
write(font,320,200,1,"PRESS SPACE TO PLAY");

fruit(160,120,11);
fruit(480,120,13);
fruit(160,360,12);
fruit(480,360,10);


WHILE(!key(_space))
FRAME;
END

WHILE(key(_space))
FRAME;
END

signal(type fruit, s_kill);
delete_text(all_text);

score = 0;
time = 60;

timer[0]=0;

write(font,0,0,0,"TIME: ");
write_int(font,200,0,0,&time);

write(font,0,50,0,"SCORE: ");
write_int(font,200,50,0,&score);

write(font,0,100,0,"HISCORE: ");
write_int(font,200,100,0,&hiscore);

fruits();

while(time>0)
    time = (6100-timer[0])/100;
    if(time<0)
        time=0;
    end

    frame;
end

signal(type fruits, s_kill_tree);

write(fontbig,320,140,1,"GAME OVER!");

if(score>hiscore)
    hiscore = score;
end

FRAME(6000);


END



END

process fruits()

private
f;
p;
t;
scored;
STRING stext;
BEGIN

LOOP
f = rand(10,13);
f=rand(0,3);
if(f)
f=rand(11,13);
else
f=10;
end

timer[1]=0;
t=rand(50,200);
scored=false;
p=fruit(320,240,f);
stext="";
write(font,320,240,4,&stext);
//"MISSED! -5 POINTS!");

while(timer[1]<t && scored==false)
    if(key(_space))
        if(f==10)
            score++;
            sound(sound_right,64,256);
            stext="HURRAH!";
        else
            score-=2;
            sound(sound_wrong,64,256);
            stext="WRONG!";
        end
        scored=true;
    end

    FRAME;
END
if(scored==false)
    if(f==10)
        sound(sound_wrong,64,256);
        score-=5;
        p.hit=true;
        stext="MISSED! -5 POINTS!";
    else
        signal(p,s_kill);
    end
else
    p.hit=true;
end

while(key(_space))
    frame;
end

frame(rand(1000,2000));

end


END



process fruit(x,y,graph)
private
tx;
ty;

begin
hit = false;

loop
    angle = rand(0,-18000);
    if(hit==true)
        tx=rand(-180000,180000);
        ty=0;
        //rand(0,640);
        //ty=rand(0,480);

        while(!out_region(id,0));
            xadvance(tx,ty);
            size--;

            ty++;

            frame;
        end
        return;
    end

    frame;
end

end


PROCESS player(x,y,trail,size)

BEGIN
GRAPH=2;

IF(trail)
    flags=4;
    WHILE(size>0)
        size-=2;
        if(get_dist(smallbro)>5)
            xadvance(get_angle(smallbro),5);
            angle=get_angle(smallbro);
        end
        FRAME;
    END
    RETURN;
ELSE

    LOOP
        x = mouse.x;
        y = mouse.y;
//        size = 125+50*(sin(timer)/1000);
        player(x,y,1,size);

        FRAME;
    END
END

END

