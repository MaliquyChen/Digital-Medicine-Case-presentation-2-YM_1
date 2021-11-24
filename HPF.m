function img_hpf = HPF(image,d)
    d0=d; %閾值
    image = uint8(255*image);
    [M,N] = size(image);

    img_f = fft2(double(image)); %FFT得到頻譜
    img_f = fftshift(img_f); %移到中間

    m_mid = floor(M/2);
    n_mid = floor(N/2);

    h = zeros(M,N);
    for i = 1:M
        for j = 1:N
            d = ((i-m_mid)^2+(j-n_mid)^2);
            h(i,j) = 1-exp(-(d)/(2*(d0^2)));
        end
    end

    img_hpf = h.*img_f;

    img_hpf = ifftshift(img_hpf); %中心移回原來狀態
    img_hpf = uint8(real(ifft2(img_hpf))); %反傅立葉，取實數部分
end

