package com.example.wearosapp;

import android.app.Activity;
import android.media.AudioDeviceInfo;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.RequiresApi;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    private AudioHelper audioHelper;
    private Button buttonExplorar;
    private Button buttonAudio;
    private Button buttonBluetooth;
    private TextView textViewAudioStatus;
    private MediaPlayer mediaPlayer;
    private Object audioDeviceCallback = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Inicializa o AudioHelper
        audioHelper = new AudioHelper(this);

        // Referências aos componentes da UI
        buttonExplorar = findViewById(R.id.buttonExplorar);
        buttonAudio = findViewById(R.id.buttonAudio);
        buttonBluetooth = findViewById(R.id.buttonBluetooth);
        textViewAudioStatus = findViewById(R.id.textViewAudioStatus);

        // Atualiza o status dos dispositivos de áudio
        updateAudioStatus();

        // Botão Explorar
        buttonExplorar.setOnClickListener(v -> {
            Toast.makeText(this, "Explorando João Pessoa!", Toast.LENGTH_SHORT).show();
        });

        // Botão Reproduzir Áudio
        buttonAudio.setOnClickListener(v -> {
            playAudio();
        });

        // Botão Conectar Bluetooth
        buttonBluetooth.setOnClickListener(v -> {
            if (!audioHelper.isBluetoothHeadsetConnected()) {
                audioHelper.openBluetoothSettings();
                Toast.makeText(this, "Abrindo configurações do Bluetooth...", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Bluetooth já está conectado!", Toast.LENGTH_SHORT).show();
            }
        });

        // Registra callback para detectar mudanças nos dispositivos de áudio
        registerAudioDeviceCallback();
    }

    /**
     * Atualiza o status dos dispositivos de áudio na interface
     */
    private void updateAudioStatus() {
        StringBuilder status = new StringBuilder();
        
        if (audioHelper.isSpeakerAvailable()) {
            status.append("✓ Alto-falante disponível\n");
        } else {
            status.append("✗ Alto-falante não disponível\n");
        }

        if (audioHelper.isBluetoothHeadsetConnected()) {
            status.append("✓ Bluetooth conectado\n");
        } else {
            status.append("✗ Bluetooth desconectado\n");
        }

        textViewAudioStatus.setText(status.toString());
    }

    /**
     * Reproduz áudio (exemplo: mensagem de boas-vindas)
     */
    private void playAudio() {
        // Verifica se há uma saída de áudio disponível
        if (!audioHelper.isSpeakerAvailable() && !audioHelper.isBluetoothHeadsetConnected()) {
            Toast.makeText(this, "Nenhum dispositivo de áudio disponível!", Toast.LENGTH_LONG).show();
            audioHelper.openBluetoothSettings();
            return;
        }

        try {
            // Para qualquer reprodução anterior
            if (mediaPlayer != null) {
                mediaPlayer.release();
            }

            // Cria um MediaPlayer para reproduzir um tom de exemplo
            // Em um app real, você usaria um arquivo de áudio ou Text-to-Speech
            mediaPlayer = MediaPlayer.create(this, android.provider.Settings.System.DEFAULT_NOTIFICATION_URI);
            
            if (mediaPlayer != null) {
                mediaPlayer.setOnCompletionListener(mp -> {
                    mp.release();
                    mediaPlayer = null;
                    Toast.makeText(MainActivity.this, "Áudio reproduzido com sucesso!", Toast.LENGTH_SHORT).show();
                });
                
                mediaPlayer.start();
                Toast.makeText(this, "Reproduzindo áudio...", Toast.LENGTH_SHORT).show();
            } else {
                // Se não conseguir criar o MediaPlayer, usa Text-to-Speech como alternativa
                speakText("Bem-vindo a João Pessoa, Paraíba! Explore esta bela cidade.");
            }
        } catch (Exception e) {
            Toast.makeText(this, "Erro ao reproduzir áudio: " + e.getMessage(), Toast.LENGTH_SHORT).show();
            // Usa Text-to-Speech como fallback
            speakText("Bem-vindo a João Pessoa, Paraíba!");
        }
    }

    /**
     * Usa Text-to-Speech para falar o texto
     */
    private void speakText(String text) {
        // Implementação básica - em um app real, você usaria TextToSpeech
        Toast.makeText(this, text, Toast.LENGTH_LONG).show();
    }

    /**
     * Registra callback para detectar mudanças nos dispositivos de áudio
     */
    @RequiresApi(api = Build.VERSION_CODES.M)
    private void registerAudioDeviceCallback() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                // Usa reflexão para criar o callback, já que pode não estar disponível em todas as versões
                Class<?> callbackClass = Class.forName("android.media.AudioManager$AudioDeviceCallback");
                Object callback = java.lang.reflect.Proxy.newProxyInstance(
                    callbackClass.getClassLoader(),
                    new Class<?>[]{callbackClass},
                    (proxy, method, args) -> {
                        String methodName = method.getName();
                        if ("onAudioDevicesAdded".equals(methodName)) {
                            runOnUiThread(() -> {
                                if (audioHelper.isBluetoothHeadsetConnected()) {
                                    Toast.makeText(MainActivity.this, "Fone de ouvido Bluetooth conectado!", Toast.LENGTH_SHORT).show();
                                }
                                updateAudioStatus();
                            });
                        } else if ("onAudioDevicesRemoved".equals(methodName)) {
                            runOnUiThread(() -> {
                                if (!audioHelper.isBluetoothHeadsetConnected()) {
                                    Toast.makeText(MainActivity.this, "Fone de ouvido Bluetooth desconectado!", Toast.LENGTH_SHORT).show();
                                }
                                updateAudioStatus();
                            });
                        }
                        return null;
                    }
                );
                audioDeviceCallback = callback;
                audioHelper.registerAudioDeviceCallback(callback);
            } catch (Exception e) {
                // Se não conseguir criar o callback, apenas ignora
                // O app ainda funcionará, mas não detectará mudanças dinâmicas
            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        
        // Remove o callback
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && audioDeviceCallback != null) {
            audioHelper.unregisterAudioDeviceCallback(audioDeviceCallback);
        }
        
        // Libera o MediaPlayer
        if (mediaPlayer != null) {
            mediaPlayer.release();
            mediaPlayer = null;
        }
    }
}
