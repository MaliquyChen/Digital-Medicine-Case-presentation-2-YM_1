function mask = masker(BW)
    MC = bwconncomp(BW);
    mask1 = zeros(1024,'uint8');
    sum = 0;
    for i=1:length(MC.PixelIdxList)
        sum = sum + length(MC.PixelIdxList{1,i});
    end
    for i=1:length(MC.PixelIdxList)
        if length(MC.PixelIdxList{1,i})/sum > 0.1
            mask1(MC.PixelIdxList{1,i}) = 255;
        end
    end
    mask1 = im2double(mask1);
%     mask2 = imfill(logical(mask1),'holes'); 
%     mask1 = mask2-logical(mask1);
    MC2 = bwconncomp(1-mask1);
    sum = 0;
    for i=1:length(MC2.PixelIdxList)
        sum = sum + length(MC2.PixelIdxList{1,i});
    end
    mask = zeros(1024,'uint8');
    for i=1:length(MC2.PixelIdxList)
        if length(MC2.PixelIdxList{1,i})/sum>0.1
            mask(MC2.PixelIdxList{1,i}) = 255;
        end
    end
end
