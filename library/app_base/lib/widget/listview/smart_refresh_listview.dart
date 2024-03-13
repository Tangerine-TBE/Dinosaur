import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

export 'package:pull_to_refresh/pull_to_refresh.dart';

/// 多类型列表
/// 自上而下
/// 支持下拉刷新、上拉加载更多
class SmartRefreshListView<T> extends StatefulWidget {
  const SmartRefreshListView({
    Key? key,
    this.pageSize = 20,
    this.padding,
    this.runSpacing = 0,
    this.fontColor = Colors.white54,
    this.controller,
    this.emptyWidget,
    required this.onRefresh,
    this.onLoadMore,
    required this.adapter,
  }) : super(key: key);

  /// 每頁數據量
  final int pageSize;

  /// 列表padding
  final EdgeInsetsGeometry? padding;

  /// item 間距
  final int runSpacing;

  /// 提示文字顏色
  final Color fontColor;

  /// 初始數據
  final RefreshController? controller;

  /// 刷新事件
  /// param: 當前頁數
  final Future<List<T>> Function() onRefresh;

  /// 加載更多事件
  /// return 是否已經沒更多數據 isNoMore
  final Future<List<T>> Function(int page, int pageSize)? onLoadMore;

  /// 空視圖
  final Widget? emptyWidget;

  /// item內容控件
  final Widget Function(T item, int index) adapter;

  @override
  State<SmartRefreshListView<T>> createState() =>
      _SmartRefreshListViewState<T>();
}

/// 使用AutomaticKeepAliveClientMixin 保存頁面狀態
class _SmartRefreshListViewState<T> extends State<SmartRefreshListView<T>>
    with AutomaticKeepAliveClientMixin {
  /// 當前頁數
  int _currentPage = 1;

  /// 每頁數據量
  late int _pageSize;

  /// 是否沒有更多數據了
  bool _isNoMore = false;

  /// 數據源
  List<T> _dataList = [];

  /// 刷新组件controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    _pageSize = widget.pageSize;
    if (widget.controller != null) {
      _refreshController = widget.controller!;
    }
  }

  /// 下拉刷新逻辑
  void _onRefresh() async {
    // if failed,use refreshFailed()

    _resetLoadMore();
    _dataList = await widget.onRefresh.call();
    _isNoMore = _dataList.length < _pageSize;

    _refreshController.refreshCompleted();
    if (mounted) {
      setState(() {});
    }
  }

  /// 上拉加载逻辑 <- 加载推荐
  void _onLoading() async {
    // if failed,use loadFailed(),if no data return,use LoadNoData()
    if (_isNoMore) {
      _refreshController.loadNoData();
      return;
    }
    List<T> loadMoreData =
        await widget.onLoadMore?.call(++_currentPage, _pageSize) ?? [];
    _dataList.addAll(loadMoreData);

    _isNoMore = loadMoreData.length < _pageSize;
    if (_isNoMore) _currentPage--;

    _isNoMore
        ? _refreshController.loadNoData()
        : _refreshController.loadComplete();
    if (mounted) {
      setState(() {});
    }
  }

  /// 重置加載更多
  void _resetLoadMore() {
    _currentPage = 1;
    _isNoMore = false;
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      enablePullUp: true,
      header: const MaterialClassicHeader(distance: 40),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          //   MsgTable.SMART_REFRESH_LISTVIEW_STR1: '上拉加載更多',
          //   MsgTable.SMART_REFRESH_LISTVIEW_STR2: '加載失敗，點擊重試',
          //   MsgTable.SMART_REFRESH_LISTVIEW_STR3: '鬆開手指進行加載',
          //   MsgTable.SMART_REFRESH_LISTVIEW_STR4: '已經到底了',
          if (mode == LoadStatus.idle) {
            body = Text('上拉加載更多',
                style: TextStyle(color: widget.fontColor));
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text('加載失敗，點擊重試',
                style: TextStyle(color: widget.fontColor));
          } else if (mode == LoadStatus.canLoading) {
            body = Text('鬆開手指進行加載',
                style: TextStyle(color: widget.fontColor));
          } else {
            body = Text('已經到底了',
                style: TextStyle(color: widget.fontColor));
          }
          return SizedBox(
            height: 55.w,
            child: Container(
              alignment: Alignment.center,
              child: body,
            ),
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _refreshController,
      child: _dataList.isNotEmpty
          ? ListView.separated(
              padding: widget.padding,
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) =>
                  widget.adapter.call(_dataList[index], index),
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: widget.runSpacing.w),
            )
          : widget.emptyWidget ?? const Offstage(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
