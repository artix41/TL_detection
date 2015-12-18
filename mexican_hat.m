function f=mexican_hat(N, sigma)
    [x y]=meshgrid(round(-N/2):round(N/2), round(-N/2):round(N/2));
    f = (1 - x.^2 -y.^2) .* exp(-1/(2*sigma^2) * (x.^2 + y.^2));
    f = f./sum(sum(f));
    surf(f);