function [x,y,d]=getLTPos(startx,starty,img)
    sz=32;
    flag=0;
    x0=startx-sz+1;
    d=2;
    while(x0~=startx)
        y0=starty-sz+1;        
        while(y0~=starty)
            flag=isBorderValid(img,sz,x0,y0,2);
            if(flag==0)
                y0=y0+1;
                continue;
            else
                break;
            end
        end
        if(flag==1)
            break;
        end
        x0=x0+1;
    end
    
    x=x0;
    y=y0;
    if(flag==0)
        d=0;
        return
    end
    while(d<5)
        for x1=x0-1:x0+1
            for y1=y0-1:y0+1
                flag=isBorderValid(img,sz,x1,y1,d+1);
                if(flag==0)
                    continue;
                else
                    break;
                end
            end
        end
        if(flag==0)
            return
        else
            x0=x1;
            y0=y1;
            d=d+1;
            x=x0;
            y=y0;
        end       
    end


