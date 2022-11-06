function [ixs,iys] = xcoord_convert(slat,slon,latref,lonref,h)
    DEG2KM = 111.195;
    DEG2R = 0.0174532;
    y = (slat-latref)*DEG2KM;
	x = (slon-lonref)*DEG2KM*cos(slat*DEG2R);
    
    ixs = int32(x/h)-1;
    iys = int32(y/h);

end