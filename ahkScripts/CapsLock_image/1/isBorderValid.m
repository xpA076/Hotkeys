function flag=isBorderValid(img,sz,x0,y0,depth)
    hh=size(img,1);
    ww=size(img,2);
    
    if (x0+sz-1>ww||y0+sz-1>hh||x0<=0||y0<=0)
        flag=0;
        return
    end
    
    for dx=0:sz-1
        for dy=0:sz-1
            if(min([dx+1,dy+1,sz-dx,sz-dy])>depth)
                continue
            end
            if(min([img(y0+dy,x0+dx,1),img(y0+dy,x0+dx,2),img(y0+dy,x0+dx,3)])<250)
                flag=0;
                return
            end
        end
    end
    flag=1;
    