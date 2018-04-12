function [Success] = Set_Error(topic, msg, error)
    msg.Position(1) = error(1);
    msg.Position(2) = error(2);
    msg.Position(3) = error(3);
    msg.Position(4) = error(4);
    msg.Position(5) = error(5);
    msg.Position(6) = error(6);
    msg.Position(7) = error(7);
    send(topic, msg);
    Success = 1;
end

