package com.nell.flutter_vap

import android.content.Context
import android.os.Environment
import android.view.View
import com.tencent.qgame.animplayer.AnimConfig
import com.tencent.qgame.animplayer.AnimView
import com.tencent.qgame.animplayer.inter.IAnimListener
import com.tencent.qgame.animplayer.util.ScaleType
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.File
import com.tencent.qgame.animplayer.Constant

internal class NativeVapView(
    private val flutterAssets: FlutterPlugin.FlutterAssets,
    binaryMessenger: BinaryMessenger,
    private val context: Context,
    id: Int,
    creationParams: Map<*, *>?
) : MethodChannel.MethodCallHandler, PlatformView {

    private val vapView: AnimView = AnimView(context)
    private var channel: MethodChannel
    private var methodResult: MethodChannel.Result? = null
    private val dir by lazy {
        // 存放在sdcard应用缓存文件中
        context.getExternalFilesDir(null)?.absolutePath ?: Environment.getExternalStorageDirectory().path
    }
    init {
        var scaleType = ScaleType.FIT_CENTER
        var fps: Int? = null
        var playLoop: Int? = null
        creationParams?.let { params ->
            if (params.containsKey("scaleType")) {
                val index = (params["scaleType"] as? Int) ?: 1
                scaleType = ScaleType.values()[index]
            }
            if (params.containsKey("fps")) {
                fps = params["fps"] as? Int
            }
            if (params.containsKey("playLoop")) {
                playLoop = params["playLoop"] as? Int
            }
        }
        vapView.setScaleType(scaleType)
        //-----------------
        vapView.enableVersion1(true);
        vapView.setVideoMode(Constant.VIDEO_MODE_SPLIT_HORIZONTAL)
        //-----------------
        fps?.let { vapView.setFps(it) }
        playLoop?.let { vapView.setLoop(it) }
        vapView.setAnimListener(object : IAnimListener {
            override fun onFailed(errorType: Int, errorMsg: String?) {
                GlobalScope.launch(Dispatchers.Main) {
                    methodResult?.success(HashMap<String, String>().apply {
                        put("status", "failure")
                        put("errorMsg", errorMsg ?: "unknown error")
                    })

                }
            }

            override fun onVideoComplete() {
                GlobalScope.launch(Dispatchers.Main) {
                    methodResult?.success(HashMap<String, String>().apply {
                        put("status", "complete")
                    })
                }
            }

            override fun onVideoDestroy() {

            }

            override fun onVideoRender(frameIndex: Int, config: AnimConfig?) {
            }

            override fun onVideoStart() {
            }

        })
        channel = MethodChannel(binaryMessenger, "flutter_vap_view_$id")
        channel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return vapView
    }

    override fun dispose() {
        channel.setMethodCallHandler(null)

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        methodResult = result
        when (call.method) {
            "playPath" -> {
                call.argument<String>("path")?.let {
                    vapView.startPlay(File(it))
                }
            }
            "playAsset" -> {
                call.argument<String>("asset")?.let {
                    val fileName = FileUtil.getFileName(flutterAssets.getAssetFilePathByName(it))
                    // 拷贝到sdcard，直接从 assets 播放，在低端手机上有几率报错
                    FileUtil.copyAssetsToStorage(context, "${dir}/$fileName", arrayOf(flutterAssets.getAssetFilePathByName(it))) {
                        vapView.startPlay(File("${dir}/$fileName"))
                    }
                    //vapView.startPlay(context.assets, flutterAssets.getAssetFilePathByName(it))
                }
            }
            "stop" -> {
                vapView.stopPlay()
            }
        }
    }


}