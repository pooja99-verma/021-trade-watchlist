import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';

class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Watchlist 1', style: TextStyle(color: Colors.black87, fontSize: 16)),
              Icon(Icons.edit, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchlistLoaded) {
                  return ReorderableListView.builder(
                    itemCount: state.stocks.length,
                    onReorder: (oldIndex, newIndex) {
                      context.read<WatchlistBloc>().add(ReorderWatchlist(oldIndex, newIndex));
                    },
                    itemBuilder: (context, index) {
                      final stock = state.stocks[index];
                      return Container(
                        key: ValueKey(stock.id),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black12)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          leading: const Icon(Icons.drag_handle, color: Colors.black54),
                          title: Text(
                            stock.symbol,
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black87),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              context.read<WatchlistBloc>().add(DeleteStock(index));
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // Changed this section to a Column to stack the two buttons
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents the column from taking up full screen height
                children: [
                  // 1. Edit Other Watchlists Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.black54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                      },
                      child: const Text('Edit other watchlists', style: TextStyle(color: Colors.black87, fontSize: 16)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Save Watchlist', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}