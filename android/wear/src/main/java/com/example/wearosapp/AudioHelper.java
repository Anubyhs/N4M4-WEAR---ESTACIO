package com.example.wearosapp;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.media.AudioDeviceInfo;
import android.media.AudioManager;
import android.os.Build;
import android.provider.Settings;

public class AudioHelper {
    private final AudioManager audioManager;
    private final Context context;

    public AudioHelper(Context context) {
        this.context = context;
        this.audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
    }

    /**
     * Retorna verdadeiro se o tipo de dispositivo de áudio especificado estiver disponível
     */
    public boolean audioOutputAvailable(int type) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return false;
        }
        
        if (!context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_AUDIO_OUTPUT)) {
            return false;
        }

        AudioDeviceInfo[] devices = audioManager.getDevices(AudioManager.GET_DEVICES_OUTPUTS);
        for (AudioDeviceInfo device : devices) {
            if (device.getType() == type) {
                return true;
            }
        }
        return false;
    }

    /**
     * Verifica se o dispositivo tem alto-falante integrado
     */
    public boolean isSpeakerAvailable() {
        return audioOutputAvailable(AudioDeviceInfo.TYPE_BUILTIN_SPEAKER);
    }

    /**
     * Verifica se um fone de ouvido Bluetooth está conectado
     */
    public boolean isBluetoothHeadsetConnected() {
        return audioOutputAvailable(AudioDeviceInfo.TYPE_BLUETOOTH_A2DP);
    }

    /**
     * Registra um callback para detectar mudanças nos dispositivos de áudio
     */
    public void registerAudioDeviceCallback(Object callback) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                java.lang.reflect.Method method = audioManager.getClass().getMethod(
                    "registerAudioDeviceCallback",
                    Class.forName("android.media.AudioManager$AudioDeviceCallback"),
                    android.os.Handler.class
                );
                method.invoke(audioManager, callback, null);
            } catch (Exception e) {
                // Se não conseguir registrar o callback, apenas ignora
            }
        }
    }

    /**
     * Remove o registro do callback
     */
    public void unregisterAudioDeviceCallback(Object callback) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            try {
                java.lang.reflect.Method method = audioManager.getClass().getMethod(
                    "unregisterAudioDeviceCallback",
                    Class.forName("android.media.AudioManager$AudioDeviceCallback")
                );
                method.invoke(audioManager, callback);
            } catch (Exception e) {
                // Se não conseguir remover o callback, apenas ignora
            }
        }
    }

    /**
     * Abre as configurações do Bluetooth para facilitar a conexão
     */
    public void openBluetoothSettings() {
        Intent intent = new Intent(Settings.ACTION_BLUETOOTH_SETTINGS);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        intent.putExtra("EXTRA_CONNECTION_ONLY", true);
        intent.putExtra("EXTRA_CLOSE_ON_CONNECT", true);
        intent.putExtra("android.bluetooth.devicepicker.extra.FILTER_TYPE", 1);
        context.startActivity(intent);
    }
}

