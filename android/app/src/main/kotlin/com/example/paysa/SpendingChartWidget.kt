package com.example.paysa

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider


/**
 * Implementation of App Widget functionality.
 */
class SpendingChartWidget : HomeWidgetProvider() {
    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
            widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                val imageName = widgetData.getString("filename", null)
                setImageViewBitmap(R.id.widget_image, BitmapFactory.decodeFile(imageName))
                // End new code
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}