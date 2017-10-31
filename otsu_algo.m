im = mean(double(imread('image150.jpg')), 3);
 
[height width] = size(im);
pixels = height * width;
 
bins = [0 : 255] + 0.5;
N = hist(reshape(im, pixels, 1), bins);
 
% Normalizing the bin frequencies to make probabilities
Nnorm = N / sum(N); 
% Cumulative probability
theta = cumsum(Nnorm); 
mu=cumsum(Nnorm .* [0 : 255]);
% Repeat on the image
% Evaluate sigB2 over the t range
sigB2 = (mu - mu(256) * theta) .^ 2 ./ (theta .* (1 - theta)); 
 
% Find the maximum value and the index where it is (this is the Otsu threshold)
[p, ot] = max(sigB2); 
 
% Thresholding
x = (im > ot); 
figure(1)
imshow(x)
figure(2)
imshow(x)
hist(x);
