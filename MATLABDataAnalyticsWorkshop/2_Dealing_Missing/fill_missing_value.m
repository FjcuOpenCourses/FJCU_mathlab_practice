x = (4:2:18)';
y = [3; NaN; NaN; 2; 4; NaN; 1; 6];

idx = ~isnan(y);

xOK = x(idx);
yOK = y(idx);

y_interp = interp1(xOK, yOK, x, 'linear');
