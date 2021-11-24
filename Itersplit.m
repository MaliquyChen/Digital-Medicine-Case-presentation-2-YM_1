function BW = Itersplit(img_hpf)
    B = img_hpf;
    %初始化閾值
    T=0.5*(double(min(B(:)))+double(max(B(:))));
    d=false;
    %通過迭代求最佳閾值
    while~d
        g=B>=T;
        Tn=0.5*(mean(B(g))+mean(B(~g)));
        d=abs(T-Tn)<0.5;
        T=Tn;
    end
    % 根據最佳閾值進行影象分割
    level=Tn/255;
    BW=im2bw(B,level);
end


