function target_box = getsubbox(pos,target_sz,im)
	%get and process the context region
	xs = floor(pos(2) + (1:target_sz(2)) - (target_sz(2)/2));
	ys = floor(pos(1) + (1:target_sz(1)) - (target_sz(1)/2));
	
	%check for out-of-bounds coordinates, and set them to the values at
	%the borders
	xs(xs < 1) = 1;
	ys(ys < 1) = 1;
	xs(xs > size(im,2)) = size(im,2);
	ys(ys > size(im,1)) = size(im,1);	
	%extract image in context region
	target_box = im(ys, xs, :);	
	%pre-process window
    target_box = double(target_box);
    target_box = (target_box-mean(target_box(:)));%normalization
end