import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/live_indices_banner.dart';
import '../widgets/stock_tile.dart';

class MainWatchlistScreen extends StatefulWidget {
  const MainWatchlistScreen({super.key});

  @override
  State<MainWatchlistScreen> createState() => _MainWatchlistScreenState();
}

class _MainWatchlistScreenState extends State<MainWatchlistScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          toolbarHeight: 65,
          title: const LiveIndicesBanner(),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            _buildTabBar(),
            _buildSortButton(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildWatchlistList(context),
                  const Center(child: Text('Watchlist 5 is empty')),
                  const Center(child: Text('Watchlist 6 is empty')),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.shade700,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              activeIcon: Icon(Icons.bookmark),
              label: 'Watchlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              activeIcon: Icon(Icons.pie_chart),
              label: 'Portfolio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for instruments',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.black,
      indicatorWeight: 2,
      tabs: [
        Tab(text: 'Watchlist 1'),
        Tab(text: 'Watchlist 5'),
        Tab(text: 'Watchlist 6'),
      ],
    );
  }

  Widget _buildSortButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.sort, size: 16, color: Colors.black87),
              SizedBox(width: 6),
              Text('Sort by', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatchlistList(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {

        if (state is WatchlistLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }
        if (state is WatchlistError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    context.read<WatchlistBloc>().add(LoadWatchlist());
                  },
                  child: const Text('Retry', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        if (state is WatchlistLoaded) {
          if (state.stocks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text(
                    'Your watchlist is empty',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.read<WatchlistBloc>().add(LoadWatchlist()),
                    child: const Text('Reload Default Stocks'),
                  )
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: state.stocks.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
            itemBuilder: (context, index) {
              return StockTile(stock: state.stocks[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}