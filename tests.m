% test points2planedistance and point2planesdistance

clc;


%% Example #1
% Single point, single plane

M = [1 1 1];
I = [1 0 0];
n = M;
[d2H, H] = points2planedistance(M, n ,I) % expected distance : 2/sqrt(3); expected coordinates : [1/3 1/3 1/3]
[d2H, H] = point2planesdistance(M, n ,I) % idem


%% Example #2
% Multiple points, single plane -> specific to points2planedistance

M = [1 1 1; 2 1 1];
I = [1 0 0];
n = [1 1 1];
[d2H, H] = points2planedistance(M, n ,I) % expected distances : 2/sqrt(3), sqrt(3); expected coordinates : [1/3 1/3 1/3], [1 0 0].


%% Example #3
% Single point, multiple planes -> specific to point2planesdistance

M = [0 0 0];

% Cube included in the unist sphere
V = (sqrt(3)/3)*[ 1  1  1;
                 -1  1  1;
                 -1 -1  1;
                  1 -1  1;
                  1  1 -1;
                 -1  1 -1;
                 -1 -1 -1;
                  1 -1 -1];

% 6 normals to the cube faces
n = [ 1  0  0;
      0  1  0;
     -1  0  0;
      0 -1  0;
      0  0  1;
      0  0 -1];

I = (sqrt(3)/3)*n;

[d2H, H] = point2planesdistance(M, n ,I) % expected results : d2H = (sqrt(3)/3)*ones(6,1); H = I;
