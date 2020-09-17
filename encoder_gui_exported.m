classdef encoder_gui_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        EncoderUIFigure               matlab.ui.Figure
        ArithmeticencoderLabel        matlab.ui.control.Label
        AlphabetEditFieldLabel        matlab.ui.control.Label
        AlphabetEditField             matlab.ui.control.EditField
        ProbabilityvectorEditFieldLabel  matlab.ui.control.Label
        ProbabilityvectorEditField    matlab.ui.control.EditField
        StringtoencodeEditFieldLabel  matlab.ui.control.Label
        StringtoencodeEditField       matlab.ui.control.EditField
        EncodeButton                  matlab.ui.control.Button
        EncodedvectorEditFieldLabel   matlab.ui.control.Label
        EncodedvectorEditField        matlab.ui.control.EditField
        StrippedencodedmessageEditFieldLabel  matlab.ui.control.Label
        StrippedencodedmessageEditField  matlab.ui.control.EditField
        CommentLabel                  matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: EncodeButton
        function encode(app, event)
            % Get input alphabet
            alphabet = app.AlphabetEditField.Value;
            alphabet = strrep(alphabet,' ','');
            app.AlphabetEditField.Value = alphabet;
            if isempty(alphabet)
                uialert(app.EncoderUIFigure,"Input alphabet cannot be empty","Error");
                return
            end
            
            if length(unique(alphabet)) < length(alphabet)
                uialert(app.EncoderUIFigure, "Input alphabet must not contain duplicate charcaters","Error");
                return
            end
            % Get probability vector
            prob = str2num(app.ProbabilityvectorEditField.Value);
            if length(prob) ~= length(alphabet)
                uialert(app.EncoderUIFigure, "Probability vector is invalid","Error");
                return
            end
            % Normalize probability vector
            prob = prob/sum(prob);
            
            % Get message
            msg = app.StringtoencodeEditField.Value;
            % Remove spaces
            msg = strrep(msg, ' ', '');
            if isempty(msg)
                uialert(app.EncoderUIFigure,"String to encode cannot be empty","Error");
                return
            end
            % Check for characters in the message that are not in the
            % alphabet
            if any(~ismember(msg,alphabet))
                uialert(app.EncoderUIFigure,"All characters in the string to encode must be contained in the alphabet","Error");
                return
            end
            
            % Output
            [code, msg] = arit_encoder(alphabet, prob, msg);
            app.StrippedencodedmessageEditField.Value = msg;
            app.EncodedvectorEditField.Value = strrep(num2str(code),' ','');
            msgLength = length(msg);
            codeLength = length(code);
            rate = codeLength/msgLength;
            commentString = sprintf('%d characters of message encoded in %d bits\n(%.2f bits/char)',msgLength,codeLength, rate);
            app.CommentLabel.Text = commentString;
            app.CommentLabel.Visible = true;
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create EncoderUIFigure and hide until all components are created
            app.EncoderUIFigure = uifigure('Visible', 'off');
            app.EncoderUIFigure.Position = [100 100 403 450];
            app.EncoderUIFigure.Name = 'Encoder';

            % Create ArithmeticencoderLabel
            app.ArithmeticencoderLabel = uilabel(app.EncoderUIFigure);
            app.ArithmeticencoderLabel.HorizontalAlignment = 'center';
            app.ArithmeticencoderLabel.FontSize = 20;
            app.ArithmeticencoderLabel.Position = [117 404 172 24];
            app.ArithmeticencoderLabel.Text = 'Arithmetic encoder';

            % Create AlphabetEditFieldLabel
            app.AlphabetEditFieldLabel = uilabel(app.EncoderUIFigure);
            app.AlphabetEditFieldLabel.HorizontalAlignment = 'right';
            app.AlphabetEditFieldLabel.Position = [53 355 59 22];
            app.AlphabetEditFieldLabel.Text = 'Alphabet';

            % Create AlphabetEditField
            app.AlphabetEditField = uieditfield(app.EncoderUIFigure, 'text');
            app.AlphabetEditField.Position = [127 355 253 22];

            % Create ProbabilityvectorEditFieldLabel
            app.ProbabilityvectorEditFieldLabel = uilabel(app.EncoderUIFigure);
            app.ProbabilityvectorEditFieldLabel.HorizontalAlignment = 'right';
            app.ProbabilityvectorEditFieldLabel.Position = [14 310 98 22];
            app.ProbabilityvectorEditFieldLabel.Text = 'Probability vector';

            % Create ProbabilityvectorEditField
            app.ProbabilityvectorEditField = uieditfield(app.EncoderUIFigure, 'text');
            app.ProbabilityvectorEditField.Position = [127 310 253 22];

            % Create StringtoencodeEditFieldLabel
            app.StringtoencodeEditFieldLabel = uilabel(app.EncoderUIFigure);
            app.StringtoencodeEditFieldLabel.HorizontalAlignment = 'right';
            app.StringtoencodeEditFieldLabel.Position = [19 259 93 22];
            app.StringtoencodeEditFieldLabel.Text = 'String to encode';

            % Create StringtoencodeEditField
            app.StringtoencodeEditField = uieditfield(app.EncoderUIFigure, 'text');
            app.StringtoencodeEditField.Position = [127 259 254 22];

            % Create EncodeButton
            app.EncodeButton = uibutton(app.EncoderUIFigure, 'push');
            app.EncodeButton.ButtonPushedFcn = createCallbackFcn(app, @encode, true);
            app.EncodeButton.FontSize = 15;
            app.EncodeButton.Position = [140 192 115 39];
            app.EncodeButton.Text = 'Encode';

            % Create EncodedvectorEditFieldLabel
            app.EncodedvectorEditFieldLabel = uilabel(app.EncoderUIFigure);
            app.EncodedvectorEditFieldLabel.HorizontalAlignment = 'right';
            app.EncodedvectorEditFieldLabel.Position = [159 104 89 22];
            app.EncodedvectorEditFieldLabel.Text = 'Encoded vector';

            % Create EncodedvectorEditField
            app.EncodedvectorEditField = uieditfield(app.EncoderUIFigure, 'text');
            app.EncodedvectorEditField.Editable = 'off';
            app.EncodedvectorEditField.Position = [19 83 361 22];

            % Create StrippedencodedmessageEditFieldLabel
            app.StrippedencodedmessageEditFieldLabel = uilabel(app.EncoderUIFigure);
            app.StrippedencodedmessageEditFieldLabel.HorizontalAlignment = 'right';
            app.StrippedencodedmessageEditFieldLabel.Position = [122 156 152 22];
            app.StrippedencodedmessageEditFieldLabel.Text = 'Stripped encoded message';

            % Create StrippedencodedmessageEditField
            app.StrippedencodedmessageEditField = uieditfield(app.EncoderUIFigure, 'text');
            app.StrippedencodedmessageEditField.Editable = 'off';
            app.StrippedencodedmessageEditField.Position = [19 135 362 22];

            % Create CommentLabel
            app.CommentLabel = uilabel(app.EncoderUIFigure);
            app.CommentLabel.HorizontalAlignment = 'center';
            app.CommentLabel.FontSize = 13;
            app.CommentLabel.FontWeight = 'bold';
            app.CommentLabel.FontAngle = 'italic';
            app.CommentLabel.Visible = 'off';
            app.CommentLabel.Position = [19 19 361 46];
            app.CommentLabel.Text = 'Comment';

            % Show the figure after all components are created
            app.EncoderUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = encoder_gui_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.EncoderUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.EncoderUIFigure)
        end
    end
end