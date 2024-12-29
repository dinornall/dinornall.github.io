%{
Dinor Nallbani
Final Project
Dynamics 310
%}

% TUTORIAL %
%{
    In this tutorial I will detail the steps to find the equations of
    motion using the lagrange method. It offers a relatively simple and
    elegant way to find the equations of motion that is easier and makes
    more sense to me than the other methods we have learned in class
%}

% These are MATLAB commands to clear out the workspace
close all;
clear;
clc;

%{
    Step 1: Degrees of Freedom
This part is our first step, particularly the part where it says theta1
and theta2. This is important becauase here we are defining our degrees
of freedom which we are going to use to define how the system is going to
move. On top of that, the number of degrees of freedom tells us how many
equations of motion we will need to solve the system. In this case we
have two (theta 1 & 2) and as a result we wil have two equations of
motion.
%}
syms m1 L1 m2 L2 g theta1(t) theta2(t)

% This is defining the first derivative of our degrees of freedom (theta 1 
% & 2 dot)
dtheta1 = diff(theta1, t);
dtheta2 = diff(theta2, t);

%{
    Step 2: Postion
In the second step I found the components of the position vectors of the
center of mass of each arm in the system. I only used the a frame that was
given in the problem. Doing so makes the math more complicated if it is
done by hand, but simpler for MATLAB to do it all. Since both theta1 and
theta2 are relative to a1, I used them to find the component of each in the
a1 frame. For the a1 component of the first arm(P1), I took the half way point
rod (L1/2) as the center of mass (the rods are uniform) and multiplied that
by cos(theta1) to find the projection of that on the a1 vector. I did the
same thign with sin for the a2 component. For the second arm(P2), I added
did the same thing using the length of the second arm(L2) and theta2, but
then I added that to the double the a1 and a2 components of the first arm
because the center of mass of the second arm is the whole component of the
first arm plus half of the second arm. The 2 times cancels out the 1/2 and
makes sure that the length is correct.
%}
% Find the postition vectors of each component
r_OP1a1 = L1/2*cos(theta1); %a1 component of position vector
r_OP1a2 = L1/2*sin(theta1); %a2 component of position vector
r_OP2a1 = 2*r_OP1a1 + L2/2*cos(theta2); %a1 component of position vector
r_OP2a2 = 2*r_OP1a2 + L2/2*sin(theta2); %a2 component of position vector

%{
    Step 3: Velocity
For the third step, I found the velocity vectors of the components of the
second arm and then used them to find the whole velocity vector. I only did
the second arm because the first arm has an Instantaneous Center of
Rotation (ICR) so the calculation for kinetic energy will not need the
velocity. To find the velocity, you take the derivative of the position
components and that gives the velocity of each component. To then find the
velocity of the second arm as a whole, you use the pythagorean theorem to
take the individual components and find the actual vector magnitude.
%}
% Find the velocity vectors of each component
v_OP2a1 = diff(r_OP2a1, t);
v_OP2a2 = diff(r_OP2a2, t);
v_OP2 = sqrt(v_OP2a1^2 + v_OP2a2^2);

%{
    Step 4: Kinetic Energy
The step to find kinetic energy can be simplified to a few equations. For
the first arm, we are fortunate enough to be able to use the equation to
find the kinetic energy about the ICR. This equation can only be used when
the body has a stationary point in space that it can rotate around. This
cannot be done with the second arm because it is attached to the first arm
which is moving. The equation for the Kinetic energy of a rod about the ICR
is 1/2*I(Inertia of the body around the ICR)*angular velocity^2. The inertia
of the body about the ICR is 1/3*m1*L1^2 and the angular velocity is dtheta
which when plugged in gets us our KE for the first arm. For the second arm,
we cannot use the ICR, there is the equation 1/2*m2*v_OP2^2 + 1/2*I(the 
moment of intertia of the body around the center of mass)*angular
velocity^2. The I for the rigid rod about the center of mass is
1/12*m2*L2^2. Plugging everything in gets us our KE for the second arm.
Adding them together gets us our total kinetic energy for the system
%}
KE1 = (1/6)*m1*L1^2*dtheta1^2;
KE2 = (1/2)*m2*(v_OP2)^2 + (1/24)*m2*L2^2*dtheta2^2;
KE = KE1 + KE2;

%{
    Step 5: Potential Energy
Potential energy can be difficult to find but one way I like to think about
it is how far can the center of mass fall (since gravity is the only thing that lends 
itself to potential energy in this problem). For the first arm, the
height of the center of mass is defined by L1/2sin(theta1), the a2
component of position, and the farthest it can fall, is to a distance of 
L1/2 straight down. The h is then L1/2 + L1/2sin(theta1), but since the
L1/2 term is a constant and we take a derivative later on, we can just
ignore it. The h for the second arm ends up being L1+L2/2+L1*sin(theta1)+
L2/2*sin(theta2) but for the same reason, we can simplify it to just the
parts with theta 1 or 2
%}
PE = m1*g*(L1/2*sin(theta1)) + m2*g*(L1*sin(theta1) + L2/2*sin(theta2));

%{
    Step 6: Lagrangian
The lagrangian is a quanity that defines the state of a physical system. We
use KE-PE in most examples because that is what is used for most
non-relativistic examples.
%}
Lagrangian = KE-PE;

%{
    Step 7: The Euler-Lagrange Equation
Finally comes the last step. This is the part where we take all that we
have uncovered and use it to get some equaations of motion. Since in this
situation, we only have conservative forces (forces that are path independent)
we can set the Euler-Lagrange equation equal to 0. Now what is the
Euler-Lagrange equation? It is the time derivative of the partial
derivative of the lagrangian with respect to the time derivative of
the generalized coordinate - the partial derivative of the lagrangian with 
respect to the generalized coordinate. All this to say it's an equation
with some complicated derivation that can be used to find the equations of
motion of a system. Generalized coordinates are variables that describe the 
position and orientation of a system which in this case we use the
coordinates used to define our degrees of freedom theta1 and theta2. This
gives us two equations like we needed, one when theta1 is the generalized
coordinate and the other when its theta2. Solving this equation will give
you the equations of motion for a system
%}
eom1 = simplify(diff(diff(Lagrangian,dtheta1),t)-diff(Lagrangian,theta1))== 0; %eom with symbolic variables
eom2 = simplify(diff(diff(Lagrangian,dtheta2),t)-diff(Lagrangian,theta2))== 0; %eom with symbolic variables

% substitute the numberic values for the constants in the eoms
eom1 = subs(eom1, [m1 m2 g L1 L2], [1 0.75 9.8 0.3 0.2]); %eoms with numeric values
eom2 = subs(eom2, [m1 m2 g L1 L2], [1 0.75 9.8 0.3 0.2]); %eoms with numeric values

% graphing!
[newEqs,newVars] = reduceDifferentialOrder([eom1 eom2], [theta1(t) theta2(t)]);
[MM,F] = massMatrixForm(newEqs,newVars);
f = MM\F;
odefun = odeFunction(f,newVars);
simulationTime = 20; %in seconds
[tout, yout] = ode45(odefun, 0:.001:simulationTime, [pi/4 pi/2 0 0]);
figure(1);
hold on
plot(tout, yout(:,1), 'b')
plot(tout, yout(:,2), 'r')
xlabel('time (s)');
ylabel('theta (rad)');
legend({'Theta 1','Theta 2'},'Location','northeast')
hold off
