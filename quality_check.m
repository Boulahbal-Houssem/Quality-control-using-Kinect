clear all 
clc
%On charge les donnees du modele
load('modele.mat');
%On charge les donnees du nuage a traiter
load('data03.mat');


%% **********************************************************************
% Partie 1.2-2

% On appelle l'algo ICP pour recuperer les transformations a appliquer,
% l'erreur totale, et le temps d'execution
%   ******* A completer ******* %
[TR, TT, ER,t] = icp(modele,data,15);
icp_model =  TR*data + TT;
% On applique la transformation retournee par ICP
%   ******* A completer ******* %


% On affiche le modele et les donnees avant transformation
figure;
subplot(2,2,1);
plot3(modele(1,:),modele(2,:),modele(3,:),'bo',data(1,:),data(2,:),data(3,:),'r.');
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
title('Avant transformation, bleu: modele - rouge: data');

% On affiche le modele et les donnees auquelles ont ete appliquees la transformation
%   ******* A decommenter et completer ******* %

subplot(2,2,2);
plot3(modele(1,:),modele(2,:),modele(3,:),'bo',icp_model(1,:),icp_model(2,:),icp_model(3,:),'r.');
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
title('ICP result');

%% Affichage de l'erreur
subplot(2,2,[3 4]);
plot(0:15,ER,'--x');
xlabel('iteration#');
ylabel('d_{RMS}');
legend('bruteForce matching');
title(['Total elapsed time: ' num2str(t(end),2) ' s']);

erreur = min(ER)


