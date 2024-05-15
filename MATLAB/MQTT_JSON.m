myMQTT = mqttclient('tcp://mqtt.eclipseprojects.io', Port = 1883);
Topic_sub = "Test";

filePath = 'D:\NCKH\CODE\Human-Activity-Recognition\MQTT2FIREBASE.py';

command = ['cmd /c start "" python "', filePath, '"'];
status = system(command);

if status == 0
    disp('Command executed successfully.');
else
    disp('Error executing command.');
end

ax = 0;
ay = 0;
az = 0;
gx = 0;
gy = 0;
gz = 0;
global temp;
temp = 0;
global buff;
buff = zeros(1,100,6);
global i;
i = 1;
global params;
params= importONNXFunction("D:\NCKH\CODE\Human-Activity-Recognition\MATLAB\model_onnx2.onnx","modelHAR");



data_acc = struct('ax', ax, 'ay', ay, 'az', az);
data_gy = struct('gx', gx, 'gy', gy, 'gz', gz);
hfig = figure;clf
hax = axes(hfig);



anim_lineaX = animatedline('Parent',hax,'Color','red','MaximumNumPoints',60);
anim_lineaY = animatedline('Parent',hax,'Color','green','MaximumNumPoints',60);
anim_lineaZ = animatedline('Parent',hax,'Color','blue','MaximumNumPoints',60);


legend('Ax', 'Ay', 'Az');

gfig = figure;clf
hgy = axes(gfig);
anim_linegX = animatedline('Parent',hgy,'Color','red','MaximumNumPoints',60);
anim_linegY = animatedline('Parent',hgy,'Color','green','MaximumNumPoints',60);
anim_linegZ = animatedline('Parent',hgy,'Color','blue','MaximumNumPoints',60);
legend('Gx', 'Gy', 'Gz');

Data = subscribe(myMQTT,Topic_sub, QualityOfService = 1, Callback = @(src, msg) handleMessage(src, msg, anim_lineaX, anim_lineaY, anim_lineaZ, anim_linegX, anim_linegY, anim_linegZ));

function handleMessage(~, message, anim_lineaX, anim_lineaY, anim_lineaZ, anim_linegX, anim_linegY, anim_linegZ)
    try
        tic;
        op = jsondecode(message);
        disp(op);

        ax = op.ax;
        ay = op.ay;
        az = op.az;
        gx = op.gx;
        gy = op.gy;
        gz = op.gz;
        global temp;
        t = op.Time;
        if t<=temp
            disp('Return');
            return
        end

        %subplot(2,1,1)
        addpoints(anim_lineaX,t,ax);
        addpoints(anim_lineaY,t,ay);
        addpoints(anim_lineaZ,t,az);

        addpoints(anim_linegX,t,gx);
        addpoints(anim_linegY,t,gy);
        addpoints(anim_linegZ,t,gz);

        temp = t;

        global buff;
        global params;
        global i;
        %buff(1, i, :) =  [ax, ay, az, gx, gy, gz];
        buff(1, i , 1) = ax;
        buff(1, i , 2) = ay;
        buff(1, i , 3) = az;
        buff(1, i , 4) = gx;
        buff(1, i , 5) = gy;
        buff(1, i , 6) = gz;
        %disp(buff(1,i,:))
        i = i + 1;
        %if isequal(size(buff), [1, 60, 6])
        if buff(1,end,end) ~= 0
           disp("Buff is full"); 
           i = 1;
           tic;
           [dense_1, ] = modelHAR(reshape(buff,[1,60,6]), params);
           [~, predicted_class] = max(dense_1);
           t1 = toc;
           disp(['Thời gian chạy của model là: ', num2str(t1), ' giây']);
           predicted_label = ["jogging","sitting","stairs","standing","walking"];
           disp("predict: ",predicted_label(predicted_class));
           buff = zeros(1, 100, 6);
        end

        %
        elapsedTime = toc;
        disp(['Thời gian chạy của callback là: ', num2str(elapsedTime), ' giây']);

    catch ME
        disp(['Lỗi khi xử lý tin nhắn: ' ME.message]);
    end
end
