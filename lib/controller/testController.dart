// import 'package:get/get.dart';
// import 'package:tipaFasion/data/testModel.dart';
// import 'package:tipaFasion/repostarys/mainRepastory.dart';

// class HomeController extends GetxController {
//   MainRepostary _userRepository;
//   final _users = <Welcome>[].obs;
//   final _paginationFilter = PaginationFilter().obs;
//   final _lastPage = false.obs;

//   List<Welcome> get users => _users.toList();
//   int get limit => _paginationFilter.value.limit;
//   int get _page => _paginationFilter.value.page;
//   bool get lastPage => _lastPage.value;

//   @override
//   onInit() {
//     _userRepository = MainRepostary();
//     ever(_paginationFilter, (_) => _getAllUsers());
//     _changePaginationFilter(1, 15);
//     super.onInit();
//   }

//   Future<void> _getAllUsers() async {
//     final usersData = await _userRepository.getMyTask(
//         _paginationFilter.value.page, _paginationFilter.value.limit);
//     if (usersData.isEmpty) {
//       _lastPage.value = true;
//     }
//     _users.addAll(usersData);
//   }

//   void changeTotalPerPage(int limitValue) {
//     _users.clear();
//     _lastPage.value = false;
//     _changePaginationFilter(1, limitValue);
//   }

//   void _changePaginationFilter(int page, int limit) {
//     _paginationFilter.update((val) {
//       val.page = page;
//       val.limit = limit;
//     });
//   }

//   void loadNextPage() => _changePaginationFilter(_page + 1, limit);
// }

// class PaginationFilter {
//   int page;
//   int limit;

//   @override
//   String toString() => 'PaginationFilter(page: $page, limit: $limit)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is PaginationFilter && o.page == page && o.limit == limit;
//   }

//   @override
//   int get hashCode => page.hashCode ^ limit.hashCode;
// }
