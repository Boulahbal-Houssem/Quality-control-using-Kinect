clear all
clc

load('roiX.mat');
load('roiY.mat');
load('roiZ.mat');

% % On regarde si le resultat convient
figure();
plot3(roiX,roiY,roiZ,'.');
xlabel('X'); ylabel('Y'), zlabel('Z');
box on;

%% **********************************************************************
%  Triangulation de Delaunay


TRI = delaunay(roiX,roiY);
figure()
trisurf(TRI,roiX,roiY,roiZ);

A = [roiX(TRI(:, 1))' roiY(TRI(:, 1))' roiZ(TRI(:, 1))'];
B = [roiY(TRI(:, 2))' roiY(TRI(:, 2))' roiZ(TRI(:, 2))'];
C = [roiZ(TRI(:, 3))' roiY(TRI(:, 3))' roiZ(TRI(:, 3))'];
Vac = C-A;
Vbc = C-B;
Vab = B-A;
N = cross (Vab ,Vbc) / norm(cross (Vab ,Vbc));
%% **********************************************************************
% Histogramme (elevation)

[azimuth,elevation,r] = cart2sph(N(:,1),N(:,2),N(:,3));
% Affichage de l'histogramme
hist(elevation)



%% **********************************************************************
Rotation de la scene pour recuperer les points a la surface
% de l'objet

% On recupere l'orientation des normales grace a l'histogramme

a =-0.65;
R = [ 1      0    0       ;
      0    cos(a) -sin(a) ;
      0    sin(a)  cos(a)  ];
  
roi = [roiX;roiY;roiZ];
roiR = R*roi;


%% Affichage du resultat de la rotation
figure();
plot3(roiR(1,:),roiR(2,:),roiR(3,:),'.');
xlabel('X'); ylabel('Y'), zlabel('Z');
box on;

%% Seuillage entre les points du sol et la surface de l'objet
s=size(roiR);
j=1;
for i=1:s(2)
    if (roiR(3,i) > -750)
        modele(:,j)=roiR(:,i);
        j=j+1;
    end
end


%% Affichage du resultat
figure();
plot3(modele(1,:),modele(2,:),modele(3,:),'.');
xlabel('X'); ylabel('Y'), zlabel('Z');
box on;


%% Si le resultat est correct, on sauvegarde les donnees selectionnees
save('modele.mat','modele');

